
dependency "d1" {
  config_path = "../dependency"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    ecr_url = "ecr_url-vpc-id"
  }
}

inputs = {
    ecr_url = replace(dependency.d1.outputs.ecr_url, "087285199408.dkr.ecr.us-east-1.amazonaws.com", "666.dkr.ecr.n-korea.amazonaws.com")
}