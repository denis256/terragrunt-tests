# 11 - error: the same output declared twice

## Run

```bash
export TG_EXPERIMENT=outputs-block
cd vpc
terragrunt plan
```

## Expected

```
.../11-error-duplicate-output/vpc/terragrunt.hcl declares output "vpc_id" more
than once in its outputs block. Keep one output "vpc_id" block.
```
