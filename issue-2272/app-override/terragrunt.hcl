
include "iam_role" {
  path = find_in_parent_folders("iam_role.hcl")
  merge_strategy = "no_merge"
  expose = true
}


locals {
  val = run_cmd("echo", "get_aws_account_id: ",  "${get_aws_account_id()}")
  val2 = run_cmd("echo", "value: ",  include.iam_role.locals.value)
}

