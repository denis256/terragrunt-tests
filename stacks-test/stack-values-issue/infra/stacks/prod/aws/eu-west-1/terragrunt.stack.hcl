locals {
  region_vars = {
    region = "eu-west-1"
  }
  environment = merge(local.region_vars, values.environment)
}

stack "all/aws/eu-west-1" {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/units/environments/all/aws/eu-west-1"
  path   = "prod/aws/eu-west-1"

  values = {
    environment = local.environment
  }
}
