include "envcommon" {
  path = find_in_parent_folders("common.hcl")
  expose = true
}

include "app2" {
  path = find_in_parent_folders("app2.hcl")
  expose = true
}