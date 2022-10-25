include "config" {
  path =  find_in_parent_folders("config.hcl")
  expose = true
}

dependency "module" {
  config_path =  include.config.locals.module_path
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}