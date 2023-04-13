# centralized cache 


```bash
mkdir -p $(pwd)/../.terragrunt-cache
export TERRAGRUNT_DOWNLOAD=$(pwd)/../.terragrunt-cache 
terragrunt run-all apply  --terragrunt-log-level debug
```