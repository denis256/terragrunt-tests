include "common" {
  path   = "../common/common.hcl"
}

include "inputs" {
  path   = "./inputs.hcl"
}

include "locals" {
  path   = "./locals.hcl"
  expose = true
}

include "generate" {
  path   = "./generate.hcl"
}