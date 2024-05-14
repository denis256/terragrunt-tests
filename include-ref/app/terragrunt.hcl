include "region" {
  path           = find_in_parent_folders("region.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

inputs = {
  region              = include.region.locals.region
}

