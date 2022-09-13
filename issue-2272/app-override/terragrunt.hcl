
include {
  path = find_in_parent_folders("iam_role.hcl")
  merge_strategy = "no_merge"
}


locals {
  val = run_cmd("echo", "get_aws_account_id: ",  "${get_aws_account_id()}")
}

