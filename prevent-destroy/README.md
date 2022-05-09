# Prevent destroy of module

Setup:
````
terragrunt run-all apply
````

Prepare plan:
```
terragrunt run-all plan -destroy -out plan.out --terragrunt-exclude-dir $(pwd)/module2
```

Execute plan but skip module2
```
terragrunt  run-all  apply plan.out --terragrunt-log-level debug --terragrunt-exclude-dir $(pwd)/module2
```

