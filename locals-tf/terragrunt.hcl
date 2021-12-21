locals {
    aws_region = "us-east-1"
    aws_profile = "prod"
    aws_tags = { test = "test" }
}


inputs = {
    aws_tags = local.aws_tags
}

generate "provider" {
path = "provider.tf"
if_exists = "overwrite_terragrunt"
contents = <<EOF

variable "aws_tags" {
   type = map
}

provider "aws" {
    region = "${local.aws_region}"
    profile = "${local.aws_profile}"
    default_tags {
        tags = var.aws_tags
    }
}

EOF
}