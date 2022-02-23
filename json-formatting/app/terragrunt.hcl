

inputs = {
  in_list = dependency.module1.outputs.outlist
}

dependency "module1" {
  config_path = "${get_terragrunt_dir()}/../module1"
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs = {
    outlist = ["subnet-1", "subnet-2", "subnet-3"]

  }
}