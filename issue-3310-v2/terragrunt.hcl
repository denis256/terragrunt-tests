locals {
  app = read_terragrunt_config("${get_path_to_repo_root()}/issue-3310-v2/app")
}

inputs = {
  test = local.app.inputs.test
}
