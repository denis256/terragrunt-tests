# include_in_copy examples

Test:
```
cd app
rm -rf .terragrunt-cache
terragrunt apply
# check copied files
tree .terragrunt-cache -a
```