# tfe/nonprod/encryption/terragrunt.hcl
include "root" {
  path   = find_in_parent_folders()
  #expose = true
}


include "env" {
  path = "${get_terragrunt_dir()}/../../_env/encryption.hcl"
}

inputs = {
  env = "nonprod"
}
