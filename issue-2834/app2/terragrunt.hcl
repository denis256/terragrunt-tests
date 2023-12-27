terraform {
  # Use double slack ("//") in the path so that terragrunt can support the terraform module
  # to reference its sibling modules using a relative path (e.g. ../modules/azure_tags).
  # Reference: https://developer.hashicorp.com/terraform/language/modules/sources#modules-in-package-sub-directories
  source = "."

  extra_arguments "conditional_vars" {
    commands = [
      "apply",
      "destroy",
      "plan"
    ]

    # https://terragrunt.gruntwork.io/docs/features/keep-your-cli-flags-dry/#required-and-optional-var-files
    # Syntax below is little hacky, but we want to have var files used in specific order, and the first file might not exist.
    required_var_files = concat(
      fileexists("${get_working_dir()}/${local.cluster_region}.tfvars") ? ["${get_working_dir()}/${local.cluster_region}.tfvars"] : [],
      fileexists("${get_working_dir()}/${local.cluster_region}2.tfvars") ? ["${get_working_dir()}/${local.cluster_region}2.tfvars"] : [],
      [
        local.config_settings_file_path,
        local.config_versions_file_path,
        local.config_1,
        local.config_2,
        local.config_3,
      ]
    )
  }
}

locals {
  cluster_region = "us-east-1"
  config_settings_file_path = "settings.tfvars"
  config_versions_file_path = "versions.tfvars"
  config_1 = "1.tfvars"
  config_2 = "2.tfvars"
  config_3 = "3.tfvars"
}