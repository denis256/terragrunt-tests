# Test for race conditions on downloading different terraform versions

Execution:
```
# generate multiple dependency directories
copy-template.sh

cd project
terragrunt run-all plan
```