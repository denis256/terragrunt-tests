# manifest-traversal -- arbitrary file deletion via .terragrunt-module-manifest

## Layout

```
manifest-traversal/
  attacker-module/main.tf   <- the benign-looking terraform
  forge/main.go             <- gob-encodes a forged manifest
  reproduce.sh              <- builds an attacker git repo and runs terragrunt
  cleanup.sh                <- removes /tmp sentinels and cache artifacts
```

`reproduce.sh` builds a temporary `attacker-repo.git/` and a
`consumer-git/terragrunt.hcl` whose `terraform.source` points at the
local bare git repo via `git::file://...`. From terragrunt's perspective
this is an ordinary remote source.

## Why a *local* file source is **not** a viable attack channel

Local file sources route through `internal/runner/run/file_copy_getter.go`,
which delegates to `util.CopyFolderContents`. That helper applies the
`util.TerragruntExcludes` filter, which drops every dotfile (other than
`.terraform.lock.hcl`). The attacker-supplied
`.terragrunt-module-manifest` is therefore stripped during the source
copy and never reaches the cache.

Every other go-getter backend -- git, http(s), tarball/zip, s3, gcs,
mercurial, terraform-registry -- unpacks the source verbatim, dotfiles
included. Those are the realistic attack channels.

## How to run

```
cd /projects/gruntwork/terragrunt-tests/manifest-traversal
TERRAGRUNT_BIN=/path/to/terragrunt ./reproduce.sh
```

Defaults to `terragrunt` on `$PATH`. Exit codes:
- `0` patched: all sentinels survived
- `2` vulnerable: at least one sentinel was deleted
- `1` setup failure

To compare patched vs. unpatched, build both binaries from the same
source and run the script twice with `TERRAGRUNT_BIN` pointing at each.

## Threat model and severity

### Trigger surface

The deletion runs inside `DownloadTerraformSource()`, which fires for
any terragrunt subcommand that has to materialize the module cache:

- `terragrunt run -- init` (the canonical first command)
- `terragrunt run -- validate`
- `terragrunt run -- plan`
- `terragrunt run -- apply`
- `terragrunt hclvalidate` against a config that pulls a module
- `terragrunt run --all <anything>` over a tree of units

In short: any user who points terragrunt at a malicious module source
once, with any non-trivial subcommand, is exposed. The user does **not**
have to apply, evaluate a `data` block, or invoke a `provisioner` for
the deletion to fire.

### What can it delete

The attacker controls absolute paths. Examples of damage in a typical
CI runner:

| Target | Effect |
|---|---|
| `~/.aws/credentials` | breaks subsequent AWS calls; may trigger fallback to instance-metadata role and silent privilege change |
| `~/.ssh/known_hosts` | next git/ssh hops accept attacker MITM (TOFU prompt) |
| `~/.terraformrc` / `~/.terraform.d/credentials.tfrc.json` | next `terraform` falls back to a default registry |
| `**/.terraform.lock.hcl` (across other workspaces) | next plan unpins providers; opens a window for dependency confusion against the registry |
| `**/terraform.tfstate*` (local-state setups) | state loss; recovery requires backup |
| `.github/workflows/*.yml` | silently disables CI security checks before the next push is reviewed |
| `before_hook` / `after_hook` script files referenced by sibling units | breaks deploy orchestration |
| user's git working tree / repo cache | local development corruption |

### Severity comparison vs. `data "external"` and `local-exec`

| Vector | Capability | Trigger | What the user must do |
|---|---|---|---|
| `data "external"` | arbitrary code execution (any program with stdin/stdout) | `terragrunt run -- plan` resolves the data source | render a plan against the module |
| `local-exec` provisioner | arbitrary shell execution | `terragrunt run -- apply` | apply the module |
| forged module manifest (this) | arbitrary file deletion (no execution) | any subcommand that downloads source from a non-local source | just point terragrunt at the module |

Take-aways:
1. **Capability ceiling is lower** -- deletion, not execution. So strictly
   weaker than `data "external"` / `local-exec`.
2. **Trigger surface is wider** -- fires earlier in the kill chain than
   either of the above and on commands a user might run while just
   evaluating an unfamiliar module.
3. **Authentication boundary is the same** -- none extra; the user
   already had to point `terraform.source` at attacker content.

Net: **moderate** is a defensible severity. Lower than RCE primitives
because the attacker cannot directly write or execute. Higher than
"informational" because deletion of credential / lockfile / workflow
files can cascade into RCE on the next pipeline run (e.g. unpinned
providers, disabled CI gates, dependency confusion).

## What the patched code does

Two layers of defence in `internal/util/file.go` and
`internal/runner/run/download_source.go`:

1. **Containment check in `fileManifest.Clean()`**
   - `manifest.ManifestFolder` is resolved to an absolute root.
   - Each decoded `entry.Path` is run through `filepath.Abs` +
     `filepath.Rel`; entries that resolve to `..`, `.`, or anywhere
     above the root are dropped with a `Warnf`.
   - The actual unlink uses `os.OpenRoot(rootDir).Remove(rel)`, so any
     symlink component along the path that escapes the root causes the
     kernel to refuse the operation.

2. **Drop-on-fresh-download in `DownloadTerraformSource()`**
   - Whenever go-getter has just rewritten the cache (`downloaded ==
     true`), `dropDownloadedManifests` walks the working directory and
     unlinks every `.terragrunt-module-manifest` it finds before
     `util.CopyFolderContents` consumes them.

Either layer alone closes the path-traversal vector. Both layers
together also cover nested manifests inside subdirectories of the
downloaded module and the case where Layer 2 is bypassed by a future
refactor.

## Verification

A patched run leaves all three sentinels in place. Layer 2 deletes the
forged manifest before Layer 1 ever opens it, so the
"Skipping untrusted manifest entry" warning typically does not appear
in the standard reproduction. To exercise Layer 1 in isolation, add a
manifest under a subdirectory of the attacker repo (so it is missed by
the top-level wipe) and re-run; the warning will then appear.

An unpatched run prints no warning and reports
`*** VULNERABLE *** 3 of 3 sentinels were deleted`.

## Side-by-side comparison with `local-exec` and `data "external"`

`compare.sh` runs three independent attacker modules so you can read
the trigger surfaces side by side:

```
TERRAGRUNT_BIN=/path/to/terragrunt ./compare.sh
```

Each scenario sets up its own attacker git repo, plants three sentinels
in /tmp, runs the listed terragrunt subcommand, and reports how many
were deleted plus whether `/tmp/repro-manifest-traversal-rce-marker.txt`
was written (the marker proves the channel is full code execution, not
delete-only).

Confirmed against locally-built binaries from this exact tree:

| Channel | unpatched | patched | trigger | RCE? |
|---|---|---|---|---|
| forged manifest | deleted 3/3 | deleted 0/3 | `init` | no (delete only) |
| `data "external"` | deleted 3/3 | deleted 3/3 | `plan` | yes |
| `local-exec` provisioner | deleted 3/3 | deleted 3/3 | `apply` | yes |

Reading the table:

- **`local-exec` and `data "external"` are not bugs.** They are
  documented terraform features. A user who runs `plan` or `apply`
  against an unfamiliar module is opting into running its code on their
  machine. The patched build correctly does not interfere with them.
- **The forged manifest is the only channel that fires on `init`.**
  Init is the lowest-friction subcommand a user runs to "look at" a
  module. There is no plan rendered, no resource graph displayed, no
  prompt. The deletion happens silently inside go-getter cleanup.
- **Capability ceilings line up the other way.** `local-exec` /
  `data "external"` get full shell. The manifest bug is delete-only.
  Severity is "moderate" precisely because it trades capability for
  trigger-earlyness and stealth.

## Cleanup

```
./cleanup.sh
```

Removes `/tmp` sentinels, the consumer cache, the attacker git repo,
the comparison `.scratch/` workspaces, and the forge binary.
