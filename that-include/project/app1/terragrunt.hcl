include "envcommon" {
  path = find_in_parent_folders("common.hcl")
  expose = true
}

include "app1" {
  path = find_in_parent_folders("app1.hcl")
  expose = true
}