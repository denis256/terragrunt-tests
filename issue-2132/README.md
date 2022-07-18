# Passing long arguments to Terragrunt 


Initial failure case:
```
cd initial
terragrunt apply
```
Output:
```
ERRO[0001] 1 error occurred:
        * fork/exec /home/ubuntu/.tfenv/bin/terraform: argument list too long
 
ERRO[0001] Unable to determine underlying exit code, so Terragrunt will exit with error code 1 
```

Workaround through `tfvars` file:
```
cd generate-var-file
terragrunt apply
```

References:
https://github.com/gruntwork-io/terragrunt/issues/2132