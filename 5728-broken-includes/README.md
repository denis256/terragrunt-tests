# Inclusion of broken dependencies


```
terragrunt apply
```

```
17:12:30.782 ERROR  2 errors occurred:

* ./not-here does not exist

* Include configuration not found: ./test.hcl (referenced from: ./terragrunt.hcl)

17:12:30.782 ERROR  Unable to determine underlying exit code, so Terragrunt will exit with error code 1
```