include "root" {
  path   = "${get_repo_root()}/issue-2933/state.hcl"
}


terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
}

