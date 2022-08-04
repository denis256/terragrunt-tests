dependency "module" {
  config_path = "../module"


  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    file_name = "test"
  }
}

inputs = {
  value = dependency.module.outputs.file_name
}
