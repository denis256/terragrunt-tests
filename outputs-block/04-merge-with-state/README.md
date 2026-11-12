# 04 - add an output to the contract before the module has it

`vpc` declares `nat_id`, but `vpc/main.tf` does not export `nat_id` yet. With `merge_with_state = "shallow"` the mock value fills the gap after
`vpc` is applied, so `app` keeps planning. Without it the same setup is a
hard error (see `13-error-stale-declaration`).

`hcl validate` still reports `Declared output not in module` for `nat_id`
until `vpc/main.tf` gains the output. That is the reminder to finish the job.

## Run

```bash
export TG_EXPERIMENT=outputs-block
(cd vpc && terragrunt apply -auto-approve)
(cd app && terragrunt plan)
```

## Expected

```
+ nat_id = "nat-mock"     from mock_value, state has no nat_id
+ vpc_id = "vpc-real"     from state
```
