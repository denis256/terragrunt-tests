# Exclude specific directory from destroy

```
$ cd staging
$ terragrunt run-all destroy --terragrunt-exclude-dir **/vpc
```