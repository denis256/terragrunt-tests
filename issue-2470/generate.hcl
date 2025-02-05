locals {
  config            = read_terragrunt_config("versions.hcl")
  project_config    = read_terragrunt_config(find_in_parent_folders("versions.hcl"), { inputs = {} })
  combined_config   = merge(local.config.locals, local.project_config.locals)

  # Convert the providers map to the required format
  parsed_providers  = { for k, v in local.combined_config.required_providers : k => { source = v.source, version = v.version } }
}

generate "terraform_settings" {
  path      = "project_settings.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_version = "${local.combined_config.required_version}"

  required_providers {
    ${indent(4, yamlencode(local.parsed_providers))}
  }
}
EOF
}