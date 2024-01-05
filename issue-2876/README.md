
```
terragrunt apply

terragrunt state list
terragrunt state list | wc -l
terragrunt output
terragrunt output -json vpc_id
terragrunt output -json vpc_id | tee out.out
terragrunt state list
```