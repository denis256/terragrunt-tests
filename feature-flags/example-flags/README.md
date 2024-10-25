```
terragrunt apply
terragrunt apply --feature string_feature_flag=dev --feature int_feature_flag=8080
terragrunt apply --feature string_feature_flag=prod
terragrunt apply --feature int_feature_flag=9090
```