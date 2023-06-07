terraform {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=master"
}

dependency "module" {
  config_path = "../module"
  mock_outputs = {
    file = "a"
  }
}
