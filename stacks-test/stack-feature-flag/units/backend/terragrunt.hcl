feature "deploy_backend" {
  default = true
}

exclude {
  if                   = !feature.deploy_backend.value
  actions              = ["all"]
  exclude_dependencies = false
}

dependency "db" {
  config_path  = "../db"
  mock_outputs = {
    db_endpoint = "mock-db.local"
  }
}

inputs = {
  app_name    = values.app_name
  db_endpoint = dependency.db.outputs.db_endpoint
}
