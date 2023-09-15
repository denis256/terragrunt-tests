terraform {
  source = "."
}

dependency "m1" {
  config_path = "../m1"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}

dependency "m3" {
  config_path = "../m3"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}


dependency "m4" {
  config_path = "../m4"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}

dependency "m5" {
  config_path = "../m5"
  mock_outputs = {
    sensitive_file = "file.txt"
  }
}



inputs = {
  pass = file("../m1/${dependency.m1.outputs.sensitive_file}")
}