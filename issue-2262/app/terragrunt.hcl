locals {

  # Initial approach - Automatically load account-level variables
  #account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Example using get_terragrunt_dir()
  #account_vars = read_terragrunt_config("${get_terragrunt_dir()}/../config/account.hcl")

  # Example using get_repo_root()
  account_vars = read_terragrunt_config("${get_repo_root()}/issue-2262/config/account.hcl")

  print = run_cmd("echo", "${local.account_vars.locals.account}")
}
