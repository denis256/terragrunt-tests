
terraform {
  source = "."
}

dependency "common" {
  config_path = "../common"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    data = "fake-data"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  common_data = dependency.common.outputs.data
}