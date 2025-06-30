
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    data = "fake-vpc"
  }
}

dependency "s3" {
  config_path                             = "../s3"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    data = "fake-s3"
  }
}

