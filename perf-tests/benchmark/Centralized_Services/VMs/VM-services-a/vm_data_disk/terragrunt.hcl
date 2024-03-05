include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "rg" {
  config_path = find_in_parent_folders("ResourceGroup/")
}

inputs = {
  rg = dependency.rg.outputs.rg_name
}
