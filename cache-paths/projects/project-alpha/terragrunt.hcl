include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  project_name    = "alpha"
  billing_account = "111111-111111-111111"
}
