# 06 - read the contract as data

`read_terragrunt_config` exposes the `outputs` block of another unit as an
object: `outputs.mock_strategy.{allowed_commands,merge_with_state}` and
`outputs.output.<name>.mock_value`. Useful for generating docs or checks
from the contract.

## Run

```bash
export TG_EXPERIMENT=outputs-block
cd app
terragrunt render --format json | jq '.locals.declared, .locals.mocks'
```

## Expected

```json
["subnet_ids", "vpc_id"]
{"subnet_ids": ["subnet-mock-1", "subnet-mock-2"], "vpc_id": "vpc-mock"}
```
