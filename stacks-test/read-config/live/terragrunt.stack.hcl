locals {
  project_bucket = "potatoes-and-ice-cream"
  project        = "root-stack-my-project"
}

unit "app1" {
  source = "../units/app"
  path   = "app1"

  values = {
    project    = local.project
    deployment = "app1"
    config = {
      "key1" = "value1"
      "key2" = "value2"
    }
  }
}
