# Example of skipping dependencies

```
cd app
# apply all dependencies
terragrunt run-all apply

# skip mod2 dependency
skip_mod2=true terragrunt run-all apply
```