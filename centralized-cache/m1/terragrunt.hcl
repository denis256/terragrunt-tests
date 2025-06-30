
include "common" {
  path = find_in_parent_folders()
}

dependency "m2" {
  config_path = "../m2"
  mock_outputs = {
    file = "b"
  }
}
