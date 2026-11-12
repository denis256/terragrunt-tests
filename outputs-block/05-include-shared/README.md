# 05 - share a mock_strategy through include

The `outputs` block merges through `include` like the `errors` block.

```
root.hcl   outputs { mock_strategy { allowed_commands = ["validate", "plan"] } }
vpc        include with merge_strategy = "deep": strategy from root + its own outputs
db         include with the default shallow merge: its own block replaces the root block
```

## Run

```bash
export TG_EXPERIMENT=outputs-block
(cd vpc && terragrunt render)
(cd db && terragrunt render)
```

## Expected

`vpc` renders the merged block:

```hcl
outputs {
  mock_strategy {
    allowed_commands = ["validate", "plan"]
  }
  output "vpc_id" {
    mock_value = "vpc-mock"
  }
  output "subnet_ids" {
    mock_value = ["subnet-mock-1", "subnet-mock-2"]
  }
}
```

`db` renders only its own block, with no `mock_strategy`.
