
```
terragrunt run-all plan
terragrunt run-all apply
```


```
terraform plan -out plan.out
terraform show -json plan.out | jq
```