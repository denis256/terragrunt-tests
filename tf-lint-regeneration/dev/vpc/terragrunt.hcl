remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "s3-test-tg-xo1-7"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-test-tg-xo1-7"
    enable_lock_table_ssencryption = true

    dynamodb_table_tags = {
      owner = "terragrunt integration test"
      name = "Terraform lock table"
    }
  }
}

include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
  # source = "."

  before_hook "tflint" {
    commands = ["apply", "plan"]
    execute  = ["tflint"]
  }


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
  contents = <<EOF
output "o2" {
    value = "o2"
}
EOF
}