include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependencies {
  paths = [
    find_in_parent_folders("vm_setup_ssh"),
    find_in_parent_folders("config_webapp_3a"),
    find_in_parent_folders("config_webapp_3b")
    ]
}

dependency "webapp" {
  config_path = find_in_parent_folders("deploy_webapp_3/terragrunt.hcl")
}

dependency "dns" {
  config_path = find_in_parent_folders("ddns_record/terragrunt.hcl")
}

inputs = {
  fqdn = dependencies.dns.outputs.fqdn
  blah = dependencies.webapp.outputs.blah
}