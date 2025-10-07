
```
terragrunt run --non-interactive --all plan
```

```
13:59:10.962 WARN   [log-group] Config ./bus/terragrunt.hcl is a dependency of ./log-group/terragrunt.hcl that has no outputs, but mock outputs provided and returning those in dependency output.
```

```
terragrunt run --non-interactive --all apply 
```