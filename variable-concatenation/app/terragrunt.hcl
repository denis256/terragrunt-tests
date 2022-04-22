include "a" {
  path   = "${get_terragrunt_dir()}/../a.hcl"
  expose = true
}

include "b" {
  path   = "${get_terragrunt_dir()}/../b.hcl"
  expose = true
}

inputs = {
  content = "${include.a.inputs.value_a}${include.b.inputs.value_b}"
}