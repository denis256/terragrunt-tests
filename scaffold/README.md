# Scaffold testing

Test scenarios:
```
terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template --var Ref=v0.0.2

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template --var SourceUrlType=git-ssh

terragrunt scaffold git@github.com:denis256/terragrunt-tests.git//scaffold/default-template --var Ref=v0.0.2

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template --var Ref=v0.0.2 --var SourceUrlType=git-ssh

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template github.com/denis256/terragrunt-tests.git//scaffold/base-template

terragrunt scaffold github.com/denis256/terragrunt-tests.git//scaffold/default-template github.com/denis256/terragrunt-tests.git//scaffold/base-template --var Ref=v0.0.2
```

```
terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template --var SourceUrlType=git-ssh

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template --var SourceUrlType=git-ssh

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template --var Tag=6.6.6 --var SourceUrlType=git-ssj --var SourceGitSshUser=potato

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template --var Tag=6.6.6 



terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/default-template git::https://github.com/denis256/terragrunt-tests.git//scaffold/base-template

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/pass-vars --var=project_name=project-1 --var=replica_count=test666

terragrunt scaffold git::https://github.com/denis256/terragrunt-tests.git//scaffold/pass-vars --var-file=/home/denis/projects/gruntwork/terragrunt-tests/scaffold/files/pass-vars.yaml
```

```
scaffold git@github.com:denis256/terragrunt-tests.git//scaffold-test-1 --var=project_name=qwe --var-file=/home/denis/projects/gruntwork/terragrunt-tests/files/vars.yaml
```