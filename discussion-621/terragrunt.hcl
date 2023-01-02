locals {
  provider_conf = read_terragrunt_config("provider.hcl", {inputs = { config = ""}})
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1"
  ${local.provider_conf.inputs.config}
}
EOF
}