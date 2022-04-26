dependency "module1" {
  config_path = "../module1"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}

dependency "module2" {
  config_path = "../module2"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}
