feature "deploy_db" {
  default = true
}

exclude {
  if                   = !feature.deploy_db.value
  actions              = ["all"]
  exclude_dependencies = false
}

inputs = {
  db_name = values.db_name
}
