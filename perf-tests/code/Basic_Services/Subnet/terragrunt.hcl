include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "rg" {
  config_path = find_in_parent_folders("ResourceGroup/")
}

dependency "vnet" {
  config_path = find_in_parent_folders("VirtualNetwork/")
}

inputs = {
  rg      = dependency.rg.outputs.rg_name
  vnet_id = dependency.vnet.outputs.vnet_id
}
