
```
terragrunt scaffold github.com/gruntwork-io/terragrunt.git//test/fixtures/inputs $(pwd)//external-template
```

```
export dir=$(pwd)
mkdir temp
cd temp
terragrunt scaffold github.com/gruntwork-io/terragrunt.git//test/fixtures/inputs $dir//external-template
```