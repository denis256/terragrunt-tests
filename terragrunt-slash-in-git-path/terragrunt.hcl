terraform {
  source = "git::git@github.com:xyz/terraform-test-module.git//modules/test-file"


  // source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=feat/example"
  //source = "git::git@github.com:denis256/terraform-test-module.git?ref=feat/example//modules/test-file"
}

