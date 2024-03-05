include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "rg" {
  config_path = find_in_parent_folders("ResourceGroup/")
}
dependency "subnet" {
  config_path = find_in_parent_folders("Subnet/")
}
dependency "datadisk" {
  config_path = find_in_parent_folders("vm_data_disk/")
}

inputs = {
  rg          = dependency.rg.outputs.rg_name
  subnet_id   = dependency.subnet.outputs.subnet_id
  datadisk_id = dependency.datadisk.outputs.datadisk_id
}
