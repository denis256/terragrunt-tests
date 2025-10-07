dependency "dependency" {
  config_path = "../dependency"

  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    cluster_name = "cluster_name"
    eventbridge_bus_name = "admin-FAKE"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}



inputs = {
  content = dependency.dependency.outputs.cluster_name
}