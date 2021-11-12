# Separeated terraform and terragrunt files

Example usage of separated terragrunt and terraform files


Example usage:
```
mkdir -p /var/tmp/fccache

cd stack-base/mod3

terragrunt run-all apply --terragrunt-download-dir '/var/tmp/fccache' --terragrunt-non-interactive --terragrunt-working-dir "$(pwd)" --terragrunt-log-level 'trace' --terragrunt-source-update
```