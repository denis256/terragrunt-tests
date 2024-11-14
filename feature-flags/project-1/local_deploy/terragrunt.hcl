include "root" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = feature.aws_deploy.value || feature.gcp_deploy.value
  actions = ["apply"]
  exclude_dependencies = feature.aws_deploy.value || feature.gcp_deploy.value
}
