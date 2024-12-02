include "common" {
  path = find_in_parent_folders("common.hcl")
}

dependency "failing_dep" {
  config_path = "../failing_dep"
}

inputs = {
  data = dependency.failing_dep.outputs.value
}