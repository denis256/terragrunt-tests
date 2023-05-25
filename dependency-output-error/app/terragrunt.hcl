dependency "module1" {
  config_path = "../module1"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    data = "fake-vpc-id"
  }
}

dependency "module2" {
  config_path = "../module2"
  mock_outputs_allowed_terraform_commands = ["plan"]
  mock_outputs = {
    data = "fake-vpc-id"
  }
}

inputs = {
  data1 = dependency.module1.outputs.data
  data2 = dependency.module2.outputs.data
}