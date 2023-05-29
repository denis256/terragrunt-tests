include "root" {
  path = find_in_parent_folders()
}

dependency "module1" {
  config_path = "../module1"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    result = "mock1"
  }
}

dependency "module2" {
  config_path = "../module2"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    result = "mock2"
  }
}

dependency "module3" {
  config_path = "../module3"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    result = "mock3"
  }
}

dependency "module4" {
  config_path = "../module4"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    result = "mock4"
  }
}

inputs = {
  module1 = dependency.module1.outputs.result
  module2 = dependency.module2.outputs.result
  module3 = dependency.module3.outputs.result
  module4 = dependency.module4.outputs.result
}