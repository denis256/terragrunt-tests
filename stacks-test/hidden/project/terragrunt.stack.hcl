stack "root-config" {
  source = "${get_repo_root()}/stack-test/hidden/config/root"
  path   = "root-config"
  hidden = true
}

stack "dev" {
  source = "${get_repo_root()}/stack-test/hidden/stacks/dev"
  path   = "dev"
}

stack "prod" {
  source = "${get_repo_root()}/stack-test/hidden/stacks/prod"
  path   = "prod"
}

