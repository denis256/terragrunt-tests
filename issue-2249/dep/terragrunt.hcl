
include "common" {
  path   = find_in_parent_folders("common.hcl")
  expose = true
  merge_strategy = "deep"
}
