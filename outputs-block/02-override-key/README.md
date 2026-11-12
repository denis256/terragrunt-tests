# 02 - override one key from the dependent

The dependent keeps `mock_outputs`, but only for the key it wants to change.
`vpc_id` comes from the dependent, `subnet_ids` still comes from the
`outputs` block of `vpc`.

Precedence: real state > dependent `mock_outputs[key]` > dependency
`output "key" { mock_value }`.

## Run

```bash
export TG_EXPERIMENT=outputs-block
cd app
terragrunt plan
```

## Expected

```
+ subnet_ids = ["subnet-mock-1", "subnet-mock-2"]
+ vpc_id     = "vpc-override"
```
