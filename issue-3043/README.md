
```
cd alb
terragrunt apply

cd ../ecs
terragrunt plan -json --terragrunt-json-log --terragrunt-tf-logs-to-json  --terragrunt-include-module-prefix
terragrunt apply --terragrunt-json-log --terragrunt-tf-logs-to-json  --terragrunt-include-module-prefix
```