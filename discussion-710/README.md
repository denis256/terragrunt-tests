# Plan generation and usage

Example of plan generation and usage with Terragrunt
```bash
terragrunt run-all init
terragrunt run-all plan
ls plan/
terragrunt run-all apply terraform.tfplan
```

Cleanup:
```bash
rm -rf ./plan/*
find . -type d -name '.terragrunt-cache' -exec rm -rf {} +
find . -type f -name '.terraform.lock.hcl' -exec rm -rf {} +
find . -type f -name '*.tfstate' -exec rm -rf {} +
find . -type f -name '*.tfplan' -exec rm -rf {} +
find . -type f -name 'tfplan' -exec rm -rf {} +
find . -type f -name '*.txt' -exec rm -rf {} +
```