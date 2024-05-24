
locals {
  config = yamldecode(file("${get_terragrunt_dir()}/api.yaml"))
}

inputs = {
  api_key = local.config.api_key
}