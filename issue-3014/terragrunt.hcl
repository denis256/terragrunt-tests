remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "REDUCTED"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "REDUCTED"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  shared_config_files      = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  version                  = "5.41.0"
}
EOF
}


terraform {
  //source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
}

