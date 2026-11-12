# 10 - error: outputs block without the experiment

The block is a hard parse error unless the `outputs-block` experiment is on.
The error names the flag and the env var.

## Run

```bash
unset TG_EXPERIMENT
cd vpc
terragrunt plan
```

## Expected

```
.../10-error-experiment-off/vpc/terragrunt.hcl declares an outputs block, which
needs the outputs-block experiment. Enable it with --experiment outputs-block or
TG_EXPERIMENT=outputs-block, or remove the block.
```
