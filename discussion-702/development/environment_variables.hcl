locals {
  environment = basename(dirname(find_in_parent_folders("environment_variables.hcl")))
  //environment = basename(dirname(find_in_parent_folders("backend_configuration.hcl")))
}

inputs = {
  environment = local.environment
}