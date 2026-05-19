locals {
  env = "test"
}

stack "aws" {
  source = "../catalog/stacks/cloud"
  path   = "aws"
  values = {
    cloud = "aws"
  }
}

stack "gcp" {
  source = "../catalog/stacks/cloud"
  path   = "gcp"
  values = {
    cloud = "gcp"
  }
}
