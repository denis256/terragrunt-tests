include "aws_configs" {
  path = "../configs/aws.hcl"
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
