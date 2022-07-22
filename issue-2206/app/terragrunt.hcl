include "aws_configs" {
  path = find_in_parent_folders("aws_config.hcl")
  expose = true
}

generate = {
  test = {
    path      = "providers.tf"
    if_exists = "overwrite"
    contents  = <<EOF
terraform {
  required_providers {
    mycloud = {
      source  = "hashicorp/aws"
      version = "~> ${include.aws_configs.locals.aws_version}"
    }
  }
}
EOF
  }
}
