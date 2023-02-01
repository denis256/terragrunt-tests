# Inclusion testing

```
terragrunt run-all apply
```

Exclude specific module:
```
terragrunt run-all apply --terragrunt-exclude-dir module2
```

Include specific module:
```
terragrunt run-all apply --terragrunt-include-dir module3
```