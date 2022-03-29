dependency "m1" {
  config_path = "../m1"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}


inputs = {
  pass = file("../m1/${dependency.m1.outputs.sensitive_file}")
}