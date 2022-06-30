# issue-2172

```
# local file evaluation
IS_RESTRICTED=1 terragrunt apply --terragrunt-log-level debug

# failing decrypt
IS_RESTRICTED=0 terragrunt apply --terragrunt-log-level debug
```

https://github.com/gruntwork-io/terragrunt/issues/2172