# Race condition testing

```
terragrunt run-all apply --terragrunt-non-interactive --terragrunt-log-level debug
```
Cleanup
```
find . -type d -name .terraform -exec rm -rf {} +
find . -type f -name .terraform.lock.hcl -exec rm -f {} +
```