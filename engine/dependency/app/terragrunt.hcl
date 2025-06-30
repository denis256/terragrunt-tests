include {
  path = find_in_parent_folders()
}

dependency "dependency" {
  config_path = "../dependency"
}

inputs = {
  data = dependency.dependency.outputs.data
}