# Plan generation and usage

Example of plan generation and usage with Terragrunt
```
terragrunt run-all plan
terragrunt run-all apply
```

Cleanup:
```bash
rm -rf ./plan/*
find . -type d -name '.terragrunt-cache' -exec rm -rf {} +
find . -type f -name '.terraform.lock.hcl' -exec rm -rf {} +
```