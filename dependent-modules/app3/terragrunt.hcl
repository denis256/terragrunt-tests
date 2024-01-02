
dependency "app2" {
  config_path = "../app2"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    data = "fake-app2"
  }
}

