dependency "vpc" {
  config_path = "../vpc"

  # Tighter than the allowed_commands of vpc: mocks only for validate.
  mock_outputs_allowed_terraform_commands = ["validate"]
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.subnet_ids
}
