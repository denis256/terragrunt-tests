locals {
  # The outputs block is part of the config object read_terragrunt_config returns.
  contract = read_terragrunt_config("../vpc/terragrunt.hcl")
  declared = sort(keys(local.contract.outputs.output))
  mocks    = { for name, out in local.contract.outputs.output : name => out.mock_value }
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.subnet_ids
}
