locals {
  config = read_terragrunt_config("config.hcl")
}

include "root" {
  path = find_in_parent_folders()
}