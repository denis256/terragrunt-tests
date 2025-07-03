locals {
  project = "my-project"
}

unit "broken-unit" {
  source = "./units/dev"
  path   = "dev"
  values = {
    value = local.not_existing_project
  }
}
