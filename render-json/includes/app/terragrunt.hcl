
include "inputs" {
  path   = "./inputs.hcl"
}

include "locals" {
  path   = "./locals.hcl"
  expose = true
}

include "generate" {
  path   = "./generate.hcl"
  //merge_strategy = "deep"
}