dependency "d1" {
  config_path = "../dependency"

#  mock_outputs_allowed_terraform_commands = ["validate"]
#  mock_outputs = {
#    password = "123"
#  }
}

inputs = {
  content = dependency.d1.outputs.password
}