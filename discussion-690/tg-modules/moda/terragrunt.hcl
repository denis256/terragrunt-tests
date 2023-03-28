include {
  path = find_in_parent_folders()
}

locals {
  module_name = "moda"

  values = merge(
    yamldecode(file(find_in_parent_folders("global.yaml"))),
    yamldecode(file("variables.yaml")),
  )
}

inputs = merge(
  local.values,
)

terraform {
  source = "${local.values.tf_repo_pfx}-${local.module_name}?ref=${local.values.module_branch}"
}