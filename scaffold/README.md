# Scaffold testing


```
terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/pass-vars --var=project_name=project-1
terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template
```

```
scaffold git@github.com:denis256/terragrunt-tests.git//scaffold-test-1 --var=project_name=qwe --var-file=/home/denis/projects/gruntwork/terragrunt-tests/files/vars.yaml
```