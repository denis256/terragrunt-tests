include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependencies {
  paths = [
    "${get_parent_terragrunt_dir()}/Basic_Services/DNS/VM-dns-01/dns_server"
    ]
}

dependency "vm" {
  config_path = find_in_parent_folders("vm_instance/terragrunt.hcl")
}

inputs = {
  ip_address  = dependency.vm.outputs.vm_ip
}