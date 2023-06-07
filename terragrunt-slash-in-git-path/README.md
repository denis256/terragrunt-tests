# Testing passing of --terragrunt-source-map with slashes

```

terragrunt plan --terragrunt-source-map git::git@github.com:xyz/terraform-test-module.git=git::git@github.com:denis256/terraform-test-module.git?ref=test
terragrunt plan --terragrunt-source-map git::git@github.com:xyz/terraform-test-module.git=git::git@github.com:denis256/terraform-test-module.git?ref=feat/example

git::ssh://git@github.com/myORG/terraform-modules.git
```