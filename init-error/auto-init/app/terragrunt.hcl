dependency "dep" {
  config_path = "../dep"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}