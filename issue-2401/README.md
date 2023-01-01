# Access `optional_var_files` from render json

```
terragrunt render-json
cat terragrunt_rendered.json | jq .terraform.extra_arguments.conditional_vars.optional_var_files
```
