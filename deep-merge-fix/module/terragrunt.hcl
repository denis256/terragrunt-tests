

dependency "vpc_requester" {
  config_path = "${get_parent_terragrunt_dir("root")}/requester"
}

dependency "vpc_accepter" {
  config_path = "${get_parent_terragrunt_dir("root")}/accepter"
}


include "root" {
  path = find_in_parent_folders("common.hcl")
  merge_strategy = "deep"
}

