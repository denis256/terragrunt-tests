include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependencies {
  paths = [find_in_parent_folders("vm_setup_post-cloud-init")]
}

dependency "vm" {
  config_path = find_in_parent_folders("vm_instance/terragrunt.hcl")
}

inputs = {
  ip_address  = dependency.vm.outputs.vm_ip
  vm_uuid     = dependency.vm.outputs.vm_uuid
}