locals {
  provider_vars = {
    name    = "aws"
    source  = "hashicorp/aws"
    version = "5.74.0"
    aliases = [
      {
        region = "local"
      },
      {
        region = "us-east-1"
        alias  = "prod_us_east_1"
      }
    ]
  }
  environment = merge(local.provider_vars, values.environment)
}

unit "prod/aws/eu-west-1" {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/units/prod/aws/eu-west-1"
  path   = "prod/aws/eu-west-1"

  values = {
    environment = local.environment
  }
}
