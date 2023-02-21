

terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=${include.root.locals.required_commit}"
}

include "root" {
  path = find_in_parent_folders()
  expose = true
}