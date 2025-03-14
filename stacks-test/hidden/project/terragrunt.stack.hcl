stack "root-config" {
  source = "${get_repo_root()}/stack-test/config/root"
  path   = "root-config"
  hidden = true
}

stack "dev" {
  source = "${get_repo_root()}/stack-test/stacks/dev"
  path   = "dev"
}

