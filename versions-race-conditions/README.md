# Test for race conditions on downloading different terraform versions

Execution:
```
# generate multiple dependency directories
copy-template.sh

cd project
terragrunt run-all plan
```

```
terragrunt init --terragrunt-parallelism 1  --terragrunt-log-level debug
```