# main.hcl

terraform {
  source = "/projects/gruntwork/terragrunt-tests/issue-2174/modules//empty_placeholder"
}

locals {
  module_blocks = <<EOF
    module "m1" {
      source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
    }
    module "m2" {
      source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
    }
  EOF
}

generate "modules" {
  path      = "modules.tf"
  if_exists = "overwrite_terragrunt"
  contents  = local.module_blocks
}