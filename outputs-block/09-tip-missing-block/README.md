# 09 - the tip when a dependency has no outputs block

Under the experiment, reading a dependency that declares no `outputs` block
logs one tip. It is advice, not an error. Silence it with
`--no-tip outputs-block` or `TG_NO_TIP=outputs-block`.

## Run

```bash
export TG_EXPERIMENT=outputs-block
cd app
terragrunt plan                         # tip is logged
terragrunt --no-tip outputs-block plan  # no tip
```

## Expected

```
INFO   TIP (outputs-block): A `dependency` block reads .../vpc/terragrunt.hcl,
which declares no `outputs` block. Declare its outputs and their mock values
there once, so every dependent shares them. See
https://docs.terragrunt.com/reference/experiments/active#outputs-block
```
