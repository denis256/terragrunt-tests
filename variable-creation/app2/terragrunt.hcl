
include {
  path = "${get_terragrunt_dir()}/../variables.hcl"
}

locals {
  common_vars_yaml = "common.shared.yaml"
}

inputs = merge(
  yamldecode(
    file(
      find_in_parent_folders(local.common_vars_yaml)
    )
  )
)
