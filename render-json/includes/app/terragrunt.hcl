include "common" {
  path   = "../common/common.hcl"
}

include "inputs" {
  path   = "./inputs.hcl"
}

include "locals" {
  path   = "./locals.hcl"
}

include "generate" {
  path   = "./generate.hcl"
}

locals {
  abc = "xyz"
}

terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
}

