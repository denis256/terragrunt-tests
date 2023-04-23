include "root" {
  path = find_in_parent_folders()
}


terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
  //source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
}

