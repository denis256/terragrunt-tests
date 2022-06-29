include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//mod1"
}

dependency "mod2" {
  config_path = "../../modules/mod2"
  mock_outputs = {
    qwe = "1123"
  }
}
