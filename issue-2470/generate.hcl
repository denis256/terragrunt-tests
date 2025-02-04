locals {
  config = read_terragrunt_config("versions.hcl")

}

generate "terraform_settings" {
  path      = "project_settings.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_version = "${local.config.locals.required_version}"

  required_providers {
    ${local.config.locals.required_providers}
  }
}
EOF
}