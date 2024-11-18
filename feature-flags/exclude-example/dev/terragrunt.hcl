include "common" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = !feature.dev_deploy.value
  actions = ["all"]
  exclude_dependencies = feature.dev_deploy.value
}
