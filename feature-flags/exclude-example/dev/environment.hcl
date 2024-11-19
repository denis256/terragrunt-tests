
feature "environment" {
  default = "test"
}

feature "non_prod" {
  default = false
}

exclude {
    if = !(feature.environment.value == "dev" || feature.non_prod.value)
    actions = ["all"]
    exclude_dependencies = true
}