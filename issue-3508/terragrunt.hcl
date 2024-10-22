locals {

  git_info    = jsondecode(run_cmd("--terragrunt-quiet", "./script.sh"))
}

inputs = {
  data = local.git_info
}