locals {
  x = "y"

}

include "global" {
  path   = find_in_parent_folders("global.terragrunt.hcl")
  merge_strategy = "deep"
  expose = "true"
}

