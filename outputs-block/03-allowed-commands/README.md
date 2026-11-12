# 03 - which commands may run on mocks

`mock_strategy { allowed_commands = [...] }` in the `outputs` block of `vpc`
is the default for every dependent. A dependent that sets
`mock_outputs_allowed_terraform_commands` replaces that list for itself.

```
vpc          allowed_commands = ["validate", "plan"]
app          inherits: plan works on mocks, apply does not
app-strict   mock_outputs_allowed_terraform_commands = ["validate"]: even plan refuses mocks
```

## Run

```bash
export TG_EXPERIMENT=outputs-block
(cd app && terragrunt plan)          # ok, mocks
(cd app && terragrunt apply)         # error: vpc has no outputs yet
(cd app-strict && terragrunt plan)   # error: plan is not in the allowed list of this dependent
```

## Expected

The two failing commands end with the usual dependency error:

```
... is a dependency of ... but detected no outputs. Either the target module
has not been applied yet, or the module has no outputs.
```
