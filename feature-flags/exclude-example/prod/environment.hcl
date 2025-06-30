feature "environment" {
  default = "test"
}

exclude {
  if                   = feature.environment.value != "prod"
  actions              = ["all"]
  exclude_dependencies = true
}