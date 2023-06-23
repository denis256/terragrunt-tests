
#locals {
#  c = run_cmd("cp", "${get_repo_root()}/issue-2620/variables.tf", "${get_terragrunt_dir()}/variables.tf")
#}

terraform {
  source = "."

  before_hook "copy_vars" {
    commands = ["init","plan","apply"]
    # execute  = ["cp", "${get_repo_root()}/issue-2620/variables.tf", "${get_terragrunt_dir()}/variables.tf"]

    execute  = ["cp", "${get_repo_root()}/issue-2620/variables.tf", "."]
  }
}

