# Scaffold testing


```
terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template --var SourceUrlType=git-ssh

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template github.com/denis256/terragrunt-tests.git//scaffold/base-template

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template --var SourceUrlType=git-ssh

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template?ref=6.6.6 --var SourceUrlType=git-ssh

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template?ref=6.6.6 --var SourceUrlType=git-ssj --var SourceGitSshUser=potato

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template?ref=6.6.6

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template?ref=6.6.6 --var Ref=v0.0.3

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template git::https://github.com/denis256/terragrunt-tests.git//scaffold/base-template

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/pass-vars --var=project_name=project-1 --var=replica_count=test666

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/pass-vars --var-file=/home/denis/projects/gruntwork/terragrunt-tests/scaffold/files/pass-vars.yaml
```

```
scaffold git@github.com:denis256/terragrunt-tests.git//scaffold-test-1 --var=project_name=qwe --var-file=/home/denis/projects/gruntwork/terragrunt-tests/files/vars.yaml
```