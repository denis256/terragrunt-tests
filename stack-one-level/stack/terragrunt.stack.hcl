unit "dev-api" {
  source = "${get_repo_root()}/stack-one-level/stack/api"
  path   = "api"
  values = {
    data = "dev-api 1.0.0"
  }
}
