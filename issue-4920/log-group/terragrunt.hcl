



dependency "bus" {
  config_path = "../bus"

  # Allow mocks for validate/plan; when the dependency actually has outputs,
  # Terragrunt should use the real outputs and not warn.
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    eventbridge_bus_name = "admin-FAKE"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

inputs = {
  bus_name = dependency.bus.outputs.eventbridge_bus_name
}

