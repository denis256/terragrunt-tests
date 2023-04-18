include "root" {
  path = find_in_parent_folders()
}

terraform {
  # source = "."
  # source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
  source = "git::git@github.com:gruntwork-io/terraform-aws-cis-service-catalog.git//modules/networking/vpc-mgmt?ref=v0.42.9"
}

inputs = {

  cidr_block = "10.0.0.0/16"
  num_nat_gateways = 1
  vpc_name = "test"
  aws_region = "us-east-1"
  create_resources = 1
  kms_key_arn = null

  allow_administrative_remote_access_cidrs_public_subnets = { "gruntwork" = "34.197.83.11/32" }
}

dependency "vpc" {
  config_path = "../../vpc"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }

  skip_outputs = "true"
}

#dependency "app" {
#  config_path = "../app-44"
#  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
#  mock_outputs = {
#    vpc_id = "fake-vpc-id"
#  }
#
#  skip_outputs = "true"
#}


generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = ["087285199408"]
}
EOF
}


generate "o1" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents = <<EOF
output "o1" {
    value = "o1"
}
EOF
}

generate "o2" {
  path      = "outputs2.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "o2" {
    value = "o2"
}
EOF
}