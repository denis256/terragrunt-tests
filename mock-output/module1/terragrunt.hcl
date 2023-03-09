dependency "module2" {
  config_path = "../module2"

  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs_allowed_terraform_commands = ["plan", "apply", "output"]

  mock_outputs = {
    attribute = "mock attribute"
    hello     = "mock hello"
    subnets   = {
      dummy = {
        name = "test"
      }
    }

  }
}

inputs = {
  attribute  = dependency.module2.outputs.attribute
  hello      = dependency.module2.outputs.hello
  subnetwork = dependency.module2.outputs.subnets["dummy"]["name"]
}