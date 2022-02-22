
include "env" {
  path   = "${get_terragrunt_dir()}/../env1.hcl"
  expose = true
}

dependency "module" {
  config_path = "${include.env.locals.module_path}"

  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }

}
