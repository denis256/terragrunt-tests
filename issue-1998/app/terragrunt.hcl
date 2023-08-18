dependency "dep" {
  config_path = "../dep"
  mock_outputs_allowed_terraform_commands = ["plan"]

  mock_outputs = {
    data = "mock-data"
  }
}

inputs = {
  v1 = dependency.dep.outputs.data
}