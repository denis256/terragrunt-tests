# tfe/nonprod/terragrunt.hcl
locals {
  common_vars = read_terragrunt_config("${get_terragrunt_dir()}/../../common.hcl")
}


remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "${local.common_vars.inputs.resource_prefix}-states-${get_aws_account_id()}"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "${local.common_vars.inputs.resource_prefix}-lock-table"

    s3_bucket_tags = merge(tomap({"global.env" = "Development"}), local.common_vars.inputs.default_tags)
    dynamodb_table_tags =  merge(tomap({"global.env" = "Development"}),local.common_vars.inputs.default_tags)
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1"
  default_tags {
      tags = merge(var.default_tags, tomap({"global.env" = "Development"}))
    }
}
EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      version = "~> 5.0"
      source  = "hashicorp/aws"
    }
    archive = {
      version = ">= 2.2.0"
      source  = "hashicorp/archive"
    }
    random = {
      version = ">= 3.2.0"
      source  = "hashicorp/random"
    }
  }

}

EOF

}

terraform {
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()
    arguments = [
      "-var-file=${get_terragrunt_dir()}/../../common.tfvars",
    ]
  }
}
