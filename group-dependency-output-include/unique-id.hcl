
locals {
  # read config file from each module to know in which one output is disabled
  config    = read_terragrunt_config("config.hcl")
}

dependency "unique_id" {
  config_path = format("%s/group-dependency-output-include/shared/unique-id", "/projects/gruntwork/terragrunt-tests")

  # configure outputs skipping
  skip_outputs = "${local.config.locals.disable_outputs}"

  mock_outputs = {
    id = "000000"
  }
}