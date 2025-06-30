unit "prod-unit-config" {
  source                  = "${get_repo_root()}/stacks-test/hidden/configs/prod"
  path                    = "prod-unit-config"
  no_dot_terragrunt_stack = true
}

unit "prod-api" {
  source = "${get_repo_root()}/stacks-test/hidden/units/api"
  path   = "api"
  values = {
    ver = "prod-api 1.0.0"
  }
}

unit "prod-db" {
  source = "${get_repo_root()}/stacks-test/hidden/units/db"
  path   = "db"
  values = {
    ver = "prod-db 1.0.0"
  }
}

unit "prod-web" {
  source = "${get_repo_root()}/stacks-test/hidden/units/web"
  path   = "web"
  values = {
    ver = "prod-web 1.0.0"
  }
}
