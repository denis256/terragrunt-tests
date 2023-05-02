terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/file-2?ref=master"
}

inputs = {
  file_content = "test"
}
