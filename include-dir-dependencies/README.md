

Apply only dependencies which have staging variables:
```
terragrunt run-all apply $(find . -name "staging.tfvars" -print0 | xargs -0 -n1 dirname | xargs printf -- ' --terragrunt-include-dir %s')
```
Apply only dependencies which have production variables:

```
terragrunt run-all apply $(find . -name "prod.tfvars" -print0 | xargs -0 -n1 dirname | xargs printf -- ' --terragrunt-include-dir %s')
```