# Exclusion of files and directories

```
$ terragrunt run-all plan 
[INFO] Getting version from tgenv-version-name
[INFO] TGENV_VERSION is 0.40.1
Group 1
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/ecs
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/ecs/services
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/rds
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/sqs

```

Exclude `ecs/services`
````
$ terragrunt run-all plan --terragrunt-exclude-dir **/ecs/services
[INFO] Getting version from tgenv-version-name
[INFO] TGENV_VERSION is 0.40.1
INFO[0000] The stack at /projects/gruntwork/terragrunt-tests/exclude will be processed in the following order for command plan:
Group 1
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/ecs
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/rds
- Module /projects/gruntwork/terragrunt-tests/exclude/app/terraform/live/us-east-1/sqs
```