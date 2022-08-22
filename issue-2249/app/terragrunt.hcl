dependency "dep" {
  config_path = "../dep"
  mock_outputs = {
    var = "fake-vpc-id"
  }
}

include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
  merge_strategy = "deep"
}