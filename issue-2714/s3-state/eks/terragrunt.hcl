include "root" {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs_allowed_terraform_commands = ["validate", "init", "plan"]
  mock_outputs                            = {
    vpc_id = "vpc-123456"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}