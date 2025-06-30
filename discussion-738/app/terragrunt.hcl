dependency "dep" {
  config_path = "../dependency"
}

include "inputs" {
  path           = "inputs.hcl"
  merge_strategy = "deep"
}