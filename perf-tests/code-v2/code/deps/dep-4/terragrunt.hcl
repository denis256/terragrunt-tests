include {
  path   = find_in_parent_folders()
}

dependency "common" {
  config_path = "../../common"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

inputs = {
  file_content = "test"
  common = dependency.common.outputs.vpc_id
}
