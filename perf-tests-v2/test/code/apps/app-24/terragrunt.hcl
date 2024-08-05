include {
  path   = find_in_parent_folders()
}

dependency "dep_1" {
  config_path = "../../deps/dep-1"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
dependency "dep_2" {
  config_path = "../../deps/dep-2"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
dependency "dep_3" {
  config_path = "../../deps/dep-3"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
dependency "dep_4" {
  config_path = "../../deps/dep-4"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
dependency "dep_5" {
  config_path = "../../deps/dep-5"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

inputs = {
  file_content = "test"
  dep_1 = dependency.dep_1.outputs.vpc_id
  dep_2 = dependency.dep_2.outputs.vpc_id
  dep_3 = dependency.dep_3.outputs.vpc_id
  dep_4 = dependency.dep_4.outputs.vpc_id
  dep_5 = dependency.dep_5.outputs.vpc_id

}