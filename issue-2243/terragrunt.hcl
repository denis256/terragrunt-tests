# Set common variables for the environment. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.

# The attribute `${data.aws_caller_identity.current.account_id}` will be current account number.
data "aws_caller_identity" "current" {}

# The attribue `${data.aws_iam_account_alias.current.account_alias}` will be current account alias
data "aws_iam_account_alias" "current" {}

# The attribute `${data.aws_region.current.name}` will be current region
data "aws_region" "current" {}

# Set as [local values](https://www.terraform.io/docs/configuration/locals.html)
locals {
  aws_region          = data.aws_region.current.name
  account_id          = data.aws_caller_identity.current.account_id
  account_alias       = data.aws_iam_account_alias.current.account_alias
  environment         = "dev"
  remote_state_bucket = "financial-data-api-demo-state"
}