include "root" {
  path = find_in_parent_folders()
}

dependency "app1" {
  config_path = "../app1"
  skip_outputs = true
}