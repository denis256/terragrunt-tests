terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
}

locals {
  app3 = run_cmd("echo", "app3")
}

