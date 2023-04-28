dependency "m1" {
  config_path = "../m1"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

dependency "m2" {
  config_path = "../m2"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}