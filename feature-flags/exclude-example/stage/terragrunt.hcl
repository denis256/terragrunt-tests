include "common" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = !feature.stage_deploy.value
  actions = ["all"]
  exclude_dependencies = feature.stage_deploy.value
}
