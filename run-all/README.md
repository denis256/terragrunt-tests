Apply case:
```
terragrunt run-all plan --terragrunt-out-dir /tmp/out --terragrunt-log-level debug
terragrunt run-all apply --terragrunt-out-dir /tmp/out --terragrunt-log-level debug
terragrunt run-all destroy --terragrunt-out-dir /tmp/out --terragrunt-log-level debug
```

Destroy case:
```
terragrunt run-all plan -destroy --terragrunt-out-dir /tmp/out --terragrunt-log-level debug
terragrunt run-all apply --terragrunt-out-dir /tmp/out --terragrunt-log-level debug
```