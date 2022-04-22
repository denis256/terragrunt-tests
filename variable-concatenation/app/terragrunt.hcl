include "a" {
  path   = "${get_terragrunt_dir()}/../a.hcl"
  expose = true
}

include "b" {
  path   = "${get_terragrunt_dir()}/../b.hcl"
  expose = true
}

inputs = merge (
  include.a.inputs,
  include.b.inputs,
)