```
terragrunt destroy-graph  --destroy-graph-root /projects/gruntwork/terragrunt-tests/issue-1862 --terragrunt-include-module-prefix
```


```
mod1
Group 1
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod3
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod8

Group 2
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod6

Group 3
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5

Group 4
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5-1
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5-2

Group 5
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod2

Group 6
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod1

```

```
mod4
Group 1
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod7

Group 2
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod4

```

```
mod5
Group 1
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod3
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod8

Group 2
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod6

Group 3
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5

Group 4
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5-1
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod5-2

Group 5
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod2

Group 6
- Module /projects/gruntwork/terragrunt-tests/issue-1862/mod1

```