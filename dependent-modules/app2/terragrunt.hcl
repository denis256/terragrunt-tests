
dependency "app1" {
  config_path                             = "../app1"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    data = "fake-app1"
  }
}

dependency "s3" {
  config_path                             = "../s3"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    data = "fake-s3"
  }
}



