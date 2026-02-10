feature "deploy_frontend" {
  default = true
}

exclude {
  if                   = !feature.deploy_frontend.value
  actions              = ["all"]
  exclude_dependencies = false
}

dependency "backend" {
  config_path  = "../backend"
  mock_outputs = {
    api_endpoint = "mock-api.local"
  }
}

inputs = {
  app_name     = values.app_name
  api_endpoint = dependency.backend.outputs.api_endpoint
}
