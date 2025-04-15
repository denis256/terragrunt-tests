locals {
  environment_vars = {
    env = "prod"
  }
  global_vars = {
    org_name   = get_env("ORG_NAME", "test_org")
    repository = get_env("GITHUB_REPOSITORY_NAME", "test_repo")
  }
  environment = merge(local.environment_vars, local.global_vars)
}

stack "prod/aws" {
  source = "${dirname(find_in_parent_folders("root.hcl"))}/stacks/prod/aws"
  path   = "prod/aws"

  values = {
    environment = local.environment
  }
}