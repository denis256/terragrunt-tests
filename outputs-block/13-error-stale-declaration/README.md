# 13 - error: declared output missing from the applied state

Same shape as `04-merge-with-state` but without `merge_with_state`. Once
`vpc` is applied, `app` reads real outputs, and the runtime check finds that
state has no `nat_id`, because `vpc/main.tf` never had it. The error spells out the three ways out.

Before `vpc` is applied, `app` plans fine on the mocks: the check only runs
on outputs read from state.

## Run

```bash
export TG_EXPERIMENT=outputs-block
(cd app && terragrunt plan)                   # ok: mocks, vpc not applied
(cd vpc && terragrunt apply -auto-approve)
(cd app && terragrunt plan)                   # error
```

## Expected

```
.../13-error-stale-declaration/vpc/terragrunt.hcl declares output "nat_id" in its
outputs block, but its state has no output "nat_id", read as dependency "vpc" by
.../13-error-stale-declaration/app/terragrunt.hcl. Apply .../vpc/terragrunt.hcl
after adding the output to its module, remove the declaration, or set
merge_with_state = "shallow" in its mock_strategy block to fill it from mock_value.
```
