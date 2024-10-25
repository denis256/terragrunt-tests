```
terragrunt apply
terragrunt apply --feature string_feature_flag=dev --feature int_feature_flag=8080
terragrunt apply --feature string_feature_flag=prod
terragrunt apply --feature int_feature_flag=9090

TERRAGRUNT_FEATURE=int_feature_flag=7171 terragrunt apply
TERRAGRUNT_FEATURE=int_feature_flag=9191,string_feature_flag=pilot terragrunt apply

```

