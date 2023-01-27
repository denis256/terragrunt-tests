locals {
  var1 = "test"
  var2 = "test2"
}

include "same_env" {
  path = "${local.var1}.hcl"
}

