stack "root-config" {
  source                  = "${get_repo_root()}/stack-test/hidden/configs/root"
  path                    = "root-config"
  no_dot_terragrunt_stack = true
}

stack "dev" {
  source = "${get_repo_root()}/stack-test/hidden/stacks/dev"
  path   = "dev"
}

stack "prod" {
  source = "${get_repo_root()}/stack-test/hidden/stacks/prod"
  path   = "prod"
}

