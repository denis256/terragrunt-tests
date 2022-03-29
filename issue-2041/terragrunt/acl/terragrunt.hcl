remote_state {
  backend = "s3"
  config = {
    bucket         = "denis-test-tf-state2"
    key            = "${path_relative_to_include()}/terraform3.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "denis-test-table"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}

dependency "network" {
  config_path = "../network"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    answer = "1"
  }
}

inputs = {
  value = dependency.network.outputs.answer
}