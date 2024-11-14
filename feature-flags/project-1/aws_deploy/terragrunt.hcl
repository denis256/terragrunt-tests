include "root" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = feature.exclude_aws_deploy.value
  actions = ["apply"]
  exclude_dependencies = feature.exclude_aws_deploy.value
}
