dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    mock_outputs_allowed_terraform_commands = ["plan"]
    vpc_id = "vpc-00000000"
    private_subnets = [
      "subnet-00000000",
      "subnet-00000001",
      "subnet-00000002",
    ]
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
}

