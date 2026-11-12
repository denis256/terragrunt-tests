# 08 - hcl validate catches a stale declaration and a bad reference

```
vpc   declares nat_id, but vpc/main.tf has no such output
app   references dependency.vpc.outputs.subnet_idz, which vpc does not declare
```

## Run

```bash
export TG_EXPERIMENT=outputs-block
terragrunt hcl validate
echo "exit=$?"
```

## Expected

Three diagnostics, exit code 1. The first one is HCL's own, because the
reference is evaluated against the mock object. The other two come from the
contract checks.

```
error: Unsupported attribute
 --> app/terragrunt.hcl:11:38
error: Undeclared dependency output
 --> app/terragrunt.hcl:11:16
  = dependency "vpc" declares its outputs, and "subnet_idz" is not one of them.
    Declared outputs: vpc_id, nat_id. Fix the reference or add output "subnet_idz"
    to the outputs block of the dependency.
error: Declared output not in module
 --> vpc/terragrunt.hcl:11:3
  = The outputs block declares output "nat_id", but the OpenTofu/Terraform
    module at .../08-hcl-validate-errors/vpc has no output "nat_id".
    Remove the declaration or add the output to the module.
```

`terragrunt hcl validate --format json` gives the same as machine-readable
diagnostics.
