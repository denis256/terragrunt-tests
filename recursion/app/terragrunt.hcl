include "global_configs" {
  path           = find_in_parent_folders("env.hcl")
  merge_strategy = "deep"
  expose         = true
}

inputs = {
  x = include.global_configs.locals.child_terragrunt_hcl.locals.data
}