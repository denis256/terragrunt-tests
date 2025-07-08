unit "dev-api" {
  source = "${get_repo_root()}/units/api"
  path   = "api"
  values = {
    ver = "dev-api 1.0.0"
  }
}
