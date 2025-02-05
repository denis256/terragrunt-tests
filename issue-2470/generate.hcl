# root/generate.hcl
locals {
  config            = read_terragrunt_config("versions.hcl")
  project_config    = read_terragrunt_config(find_in_parent_folders("versions.hcl", "project.hcl"), { inputs = {} })

  # Merge the providers from root and project-specific versions.hcl files
  merged_providers  = merge(
    lookup(local.config.locals, "required_providers", {}),
    lookup(local.project_config.locals, "required_providers", {})
  )

  # Use the required_version from the project-specific versions.hcl file if defined, otherwise use the one from the root versions.hcl file
  merged_required_version = coalesce(
    lookup(local.project_config.locals, "required_version", ""),
    lookup(local.config.locals, "required_version", "")
  )
}

generate "terraform_settings" {
  path      = "project_settings.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_version = "${local.merged_required_version}"

  required_providers {
    %{for provider, config in local.merged_providers}
    ${provider} = {
      source  = "${config.source}"
      version = "${config.version}"
    }
    %{endfor}
  }
}
EOF
}