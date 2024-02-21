
include "data" {
  // usage of find_in_parent_folders() - works
  path   = find_in_parent_folders("data.hcl")

  // "local" path seems to fail
  //path   = "local.hcl"
}

