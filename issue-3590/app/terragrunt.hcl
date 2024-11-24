include "root" {
  path   = find_in_parent_folders()
  expose = true
}
terraform {
  source = "${path_relative_from_include()}/."
}