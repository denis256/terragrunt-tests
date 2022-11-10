dependency app2 {
  config_path = "${path_relative_from_include()}/../app2"

  mock_outputs = {
    file = "test.txt"
  }
  mock_outputs_allowed_terraform_commands = ["validate"]
}

inputs = {
  content = dependency.app2.outputs.file
}