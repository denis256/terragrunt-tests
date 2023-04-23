include "root" {
  path = find_in_parent_folders()
}


dependency "m1" {
  config_path = "../m1"
  mock_outputs = {
    file = "a"
  }
}

dependency "m2" {
  config_path = "../m2"
  mock_outputs = {
    file = "b"
  }
}
