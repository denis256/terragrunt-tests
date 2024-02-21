```

# no projects will be applied
terragrunt run-all apply --terragrunt-strict-include --terragrunt-include-dir=p2 --terragrunt-include-dir=p3

# apply project p2
PROJECT=p2 terragrunt run-all apply --terragrunt-strict-include --terragrunt-include-dir=p2 --terragrunt-include-dir=p3

# apply project p3
PROJECT=p3 terragrunt run-all apply --terragrunt-strict-include --terragrunt-include-dir=p2 --terragrunt-include-dir=p3

```