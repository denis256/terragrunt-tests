feature "environment" {
  default = "test"
}

feature "non_prod" {
  default = false
}

exclude {
  if = (feature.environment.value == "prod" || feature.non_prod.value)
  actions = ["all"]
  exclude_dependencies = true
}