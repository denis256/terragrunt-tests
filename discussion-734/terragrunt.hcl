locals {
  config = read_terragrunt_config("${get_terragrunt_dir()}/config.hcl")
  aws_account_alias = "networking-${local.config.locals.environment}-01"
}


generate "main_tf" {
  path      = "main.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
output "aws_account_alias" {
  value = "${local.aws_account_alias}"
}
EOF
}