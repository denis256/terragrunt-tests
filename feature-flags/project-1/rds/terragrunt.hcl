
include "config" {
  path = find_in_parent_folders("config.hcl")
}

feature "exclude_prod"{
  default = true
}

exclude {
  if = feature.exclude_prod.value
  actions = ["apply"]
  exclude_dependencies = feature.exclude_prod.value
}

