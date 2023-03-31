# tests for --terragrunt-source passing

```
cd tg-modules/moda
terragrunt run-all --terragrunt-source $(pwd)/../../services/tf-service-modb  plan  --terragrunt-log-level debug
```

References:
https://github.com/gruntwork-io/knowledge-base/discussions/690