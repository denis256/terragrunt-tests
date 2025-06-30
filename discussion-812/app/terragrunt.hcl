
dependency "dep" {
  config_path                             = "../dep"
  mock_outputs_allowed_terraform_commands = ["validate", "init"]
  mock_outputs = {
    data = "fake-value"
  }
}

terraform {
  source = "."

  before_hook "app_login" {
    commands = ["apply", "destroy"]
    execute = [
      "echo", "test output:", dependency.dep.outputs.data
    ]
  }
}