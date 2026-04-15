include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  project_name = "gamma"
  member       = "group:devops@example.com"
}
