include "root" {
  path = find_in_parent_folders("common.hcl")
}

dependency "module" {
  config_path = "../app1"

  mock_outputs = {
    data = "mock"
  }

}

exclude {
  if                   = feature.gcp_deploy.value || feature.aws_deploy.value
  actions              = ["apply"]
  exclude_dependencies = feature.gcp_deploy.value || feature.aws_deploy.value
}
