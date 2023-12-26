
include "root" {
  path = find_in_parent_folders()
}

locals {
  module_config = read_terragrunt_config("config.hcl")
}
