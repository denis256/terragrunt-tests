
dependency1 "dep" {
  config_path = "../dep"

  mock_outputs = {
    data = "fake-vpc-id"
  }
}

inputs = {
  data = dependency.dep.outputs.data
}