# Testing of --terragrunt-layer-has-file implementation

Testing of `--terragrunt-layer-has-file` arguments

# Transitive dependencies test

```
cd run-all
terragrunt run-all apply --terragrunt-layer-has-file file.txt
```

# Destroy dependent modules

```
cd destroy-dependent-modules/vpc
terragrunt run-all destroy --terragrunt-layer-has-file file.txt
```