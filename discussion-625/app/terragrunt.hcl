#locals {
#  # repo dir nam
#  # root_dir = run_cmd("echo", "${basename(get_repo_root())}")
#}


locals {
  path     = "${get_terragrunt_dir()}/../.."
  root_dir = run_cmd("echo", "${dirname(local.path)}")
}

include "root" {
  path = find_in_parent_folders()
}


