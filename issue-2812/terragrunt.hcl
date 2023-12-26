terraform {
  source = "${local.module_config.locals.url}"
}

locals {
  module_config = read_terragrunt_config("config.hcl")
}