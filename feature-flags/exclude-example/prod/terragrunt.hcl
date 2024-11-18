include "common" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = !feature.prod_deploy.value
  actions = ["all"]
  exclude_dependencies = feature.prod_deploy.value
}
