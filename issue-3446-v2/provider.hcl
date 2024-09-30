
locals {
  account     = yamldecode(file("account.yaml"))
  environment = local.account.environment
  project     = yamldecode(file("${find_in_parent_folders("project.yaml")}"))
  owner       = local.project.owner
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "us-east-1"
  profile = "sandbox"
  default_tags {
    tags = {
      Environment = "${local.environment}"
      Owner       = "${local.owner}"
    }
  }
}
EOF
}
