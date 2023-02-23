include "root" {
  path = find_in_parent_folders()
}

terraform {
  # source = "."
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }

  skip_outputs = "true"
}


generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["1234567890"]
}
EOF
}


generate "o1" {
  path      = "outputs.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
output "o1" {
    value = "o1"
}
EOF
}

generate "o2" {
  path      = "outputs2.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
output "o2" {
    value = "o2"
}
EOF
}