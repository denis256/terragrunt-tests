terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/file-path?ref=master"
}

inputs = {
  file_path = "../../../../../accounts.yaml"
}
