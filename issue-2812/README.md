# Parent terragrunt config loading

Example how to load in parent terragrunt child config.

Configuration is located in `config.hcl` in each child, logic to load config is in parent `terragrunt.hcl`.

```
cd app1
terragrunt apply
# /tmp/app1: no such file or directory

cd app2
terragrunt apply
# /tmp/app2: no such file or directory
```

https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#read_terragrunt_config

