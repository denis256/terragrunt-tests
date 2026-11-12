# outputs block on units

Examples for the `outputs` block (RFC "outputs block on units"), from the
basic case to the errors it raises. A unit declares the outputs it exports
together with their mock values and a mocking strategy, so every dependent
shares one contract instead of repeating `mock_outputs`.

Every unit here is one directory with two files:

```
vpc/terragrunt.hcl   the outputs block
vpc/main.tf          the OpenTofu code, with the real output blocks
```

The `main.tf` of a dependent echoes what it received as `output` blocks, so
`plan` prints the values under "Changes to Outputs" and `apply` prints them
under "Outputs". Mock values show up before the dependency is applied, real
values after.

## Quick start

```bash
cd /projects/gruntwork/terragrunt-4 && go build -o terragrunt .   # branch build
export PATH=/projects/gruntwork/terragrunt-4:$PATH
export TG_EXPERIMENT=outputs-block

cd /projects/gruntwork/terragrunt-tests/outputs-block/01-basic
terragrunt run --all plan         # app shows the mock values: vpc is not applied yet
terragrunt run --all apply        # vpc applies first, then app with the real values
terragrunt run --all output       # the real values from state
```

`run --all plan` on a fresh tree. `vpc` plans its own real values, `app`
plans with the mocks it got from the `outputs` block of `vpc`:

```
[vpc] tofu: Changes to Outputs:
[vpc] tofu:   + subnet_ids = [
[vpc] tofu:       + "subnet-real-1",
[vpc] tofu:       + "subnet-real-2",
[vpc] tofu:     ]
[vpc] tofu:   + vpc_id     = "vpc-real"
[app] tofu: Changes to Outputs:
[app] tofu:   + subnet_ids = [
[app] tofu:       + "subnet-mock-1",
[app] tofu:       + "subnet-mock-2",
[app] tofu:     ]
[app] tofu:   + vpc_id     = "vpc-mock"
```

`run --all apply`, the `app` part:

```
[app] tofu: Outputs:
[app] tofu: subnet_ids = tolist([
[app] tofu:   "subnet-real-1",
[app] tofu:   "subnet-real-2",
[app] tofu: ])
[app] tofu: vpc_id = "vpc-real"
```

`run --all output` after that prints the same real values for both units.

OpenTofu prints outputs in a plan only when they change. Once a unit is
applied, `plan` says `No changes.` and shows no values; `run --all output`
prints them. The state lives in `.terragrunt-cache` inside each unit. To see
the mocks again after an apply, remove those directories (see Cleanup) and
plan again.

## Prerequisites

- A terragrunt built from a branch that has the block (as of 2026-11-04:
  `outputs-on-units` in `/projects/gruntwork/terragrunt-4`). The release
  binary that `mise`/`tgenv` puts on the PATH does not know the experiment
  and fails with:

  ```
  invalid value "outputs-block" for env var TG_EXPERIMENT: allowed experiment(s): ...
  ```

  If you see that, the `terragrunt` on your PATH is not the branch build.
  Put the build first on the PATH as in the quick start, or call it by its
  full path.

- `tofu` on the PATH. The OpenTofu code uses no providers, so nothing is downloaded.

## Examples

| Dir | Shows |
|---|---|
| `01-basic` | declare once in `vpc`, `app` plans on the mocks, then reads real state after apply |
| `02-override-key` | dependent `mock_outputs` overrides one key, the rest still comes from the block |
| `03-allowed-commands` | `allowed_commands` as the default, dependent tightens it for itself |
| `04-merge-with-state` | declare an output before `main.tf` has it, `shallow` fills it from the mock |
| `05-include-shared` | share `mock_strategy` from `root.hcl`, deep vs shallow include merge |
| `06-read-contract` | read the block as data with `read_terragrunt_config` |
| `07-hcl-validate` | `hcl validate --outputs` passes when declarations and references agree |
| `08-hcl-validate-errors` | stale declaration and undeclared reference as ranged diagnostics |
| `09-tip-missing-block` | the tip for a dependency without the block, and how to silence it |
| `10-error-experiment-off` | the block without the experiment is a hard error |
| `11-error-duplicate-output` | the same output declared twice |
| `12-error-invalid-block` | bad merge strategy, `type` attribute, two blocks |
| `13-error-stale-declaration` | declared output missing from applied state, the runtime check |

Each directory has its own README with the commands and the expected output.

## Run everything

`run.sh` runs every example in order, checks the expected output, and prints
one PASS or FAIL line per check. It wipes caches and state under this
directory first so runs are repeatable, and refuses to start with a binary
that does not know the experiment.

```bash
TERRAGRUNT_BIN=/projects/gruntwork/terragrunt-4/terragrunt ./run.sh
```

## Rules in one place

- Precedence for a value: real state > dependent `mock_outputs[key]` >
  dependency `output "key" { mock_value }`.
- Dependent `mock_outputs_allowed_terraform_commands` and
  `mock_outputs_merge_strategy_with_state` replace `mock_strategy` for that
  dependent when set.
- One `outputs` block per unit. It merges through `include` like `errors`:
  shallow replaces the whole block, deep merges per output name and per
  strategy attribute.
- Reading a contract never resolves the outputs of the dependency's own
  dependencies.
- The runtime check (example 13) only runs on outputs read from state. Render
  commands are exempt.
- Not in the pilot: a `type` attribute, per-output strategies, contracts for
  stack dependencies.

## Cleanup

```bash
find . -name .terragrunt-cache -type d -prune -exec rm -rf {} +
find . -name 'terraform.tfstate*' -delete
find . -name .terraform.lock.hcl -delete
```
