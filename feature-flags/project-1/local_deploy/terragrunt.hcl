include "root" {
  path   = find_in_parent_folders("common.hcl")
}

exclude {
  if = feature.gcp_deploy.value || feature.aws_deploy.value
  actions = ["apply"]
  exclude_dependencies = feature.gcp_deploy.value || feature.aws_deploy.value
}
