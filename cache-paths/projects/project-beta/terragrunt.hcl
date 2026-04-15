include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  project_name = "beta"
  member       = "serviceAccount:sa@beta.iam.gserviceaccount.com"
}
