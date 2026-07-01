# Terragrunt panic and hang reproductions

Real, minimal Terragrunt projects that crash or hang the CLI. Each subdirectory
is one self-contained case targeting a distinct codepath. Every case has its own
`README.md` with the exact command, the observed output, the root cause
(file and line), and a fix direction.

These were derived from the continuous fuzzing campaign under
`terragrunt/fuzz-state` and confirmed end to end against a real binary.

## Cases

| # | Directory | Class | Command | Codepath | Gated |
|---|-----------|-------|---------|----------|-------|
| 01 | `01-stack-numeric-interpolation-panic` | PANIC | `stack generate` | `internal/hclparse/partial_eval.go:246` AsString on a non-string template literal | yes, `--experiment stack-dependencies` |
| 02 | `02-inputs-bignum-hang` | HANG | `render` | go-cty number to string on render of an `inputs` value | no |
| 03 | `03-terraform-source-bignum-hang` | HANG | `render` | go-cty number to string while decoding `terraform.source` | no |
| 04 | `04-stack-source-bignum-hang` | HANG | `stack generate` | go-cty number to string while decoding a stack unit `source` | no |
| 05 | `05-dependency-deepmerge-nonstring-panic` | PANIC | `hcl validate` | `pkg/config/dependency.go:92` AsString on a non-string `config_path` during deep include-merge (intermittent) | no |
| 06 | `06-sensitive-marked-value-panic` | PANIC | `render` / `stack generate` | `sensitive()`-marked value not unmarked before gohcl decode or hclwrite (4 sub-cases) | no |
| 07 | `07-deep-nested-quadratic-hang` | HANG | `render --json` | `internal/ctyhelper/helper.go:96` O(depth^2) on deeply nested inputs | no |

Four distinct root causes are covered:

- Non-string template literal panic: the autoinclude partial evaluator calls
  `cty.Value.AsString()` on a numeric, bool, or float template literal. Case 01,
  with bool and float variants under `01-.../variants/`.
- Huge-exponent number hang: a literal such as `9E9999999` is coerced to a
  decimal string by go-cty, which is super-linear and never returns in practical
  time. Cases 02, 03, and 04 reach the same conversion through three different
  decode and render codepaths.
- Non-string `config_path` panic in dependency deep-merge: case 05. A sibling of
  the case 01 bug but in a different package and reachable without any experiment.
- Marked-value (`sensitive()`) panic: Terragrunt never strips cty marks before
  go-cty operations that require unmarked values, so wrapping almost any string
  attribute in `sensitive()` crashes. Case 06, four distinct codepaths.
- Quadratic nesting hang: deeply nested `inputs`/`locals` cause O(depth^2) cty
  type-equality work during input normalization. Case 07. Different mechanism
  from the huge-exponent hang.

## Build a binary to test against

```bash
cd /projects/gruntwork/terragrunt
go build -o /tmp/tg .
```

## Run everything

```bash
cd /projects/gruntwork/terragrunt-tests/panics
TG=/tmp/tg ./run_all.sh
```

Expected on the current `fuzz-testing` build:

```
01 numeric interpolation panic (gated):   PANIC
02 inputs bignum hang:                     HANG
03 terraform.source bignum hang:           HANG
04 stack source bignum hang:               HANG
05 dependency deep-merge panic:            PANIC  (intermittent, retried)
06 sensitive() marked value panic:         PANIC  x4 sub-cases
07 deep nested inputs quadratic hang:      HANG
```

## Run one case

Read that case's `README.md`, then run the command it lists from inside the
case directory. The panic case aborts with a Go stack trace. The hang cases burn
CPU and memory and have to be killed, so always wrap them in `timeout`.

## Safety

The hang cases allocate a lot of memory. Run them with a timeout, and optionally
`GOMEMLIMIT` (for example `GOMEMLIMIT=2GiB`), so a stray run cannot exhaust the
host. Never raise the exponent beyond what the case ships with.

## Cleanup

The `stack generate` cases write `.terragrunt-stack` and `.terragrunt-cache`
directories. Remove them with:

```bash
find . -name .terragrunt-stack -o -name .terragrunt-cache | xargs rm -rf
```
