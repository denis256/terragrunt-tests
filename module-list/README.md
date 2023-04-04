# fetching module list


```
$ terragrunt plan -out output.tfplan
$ terragrunt  show -no-color -json output.tfplan  | jq '.configuration.root_module.module_calls | .[] | .source
"terraform-aws-modules/ec2-instance/aws"
"terraform-aws-modules/vpc/aws"


```