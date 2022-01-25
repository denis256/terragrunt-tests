
dependency "a" {
  config_path = "../a"
  mock_outputs = {
    config_file = "file.yaml"
  }
}

inputs = {
  k8s_config = dependency.a.outputs.config_file
}