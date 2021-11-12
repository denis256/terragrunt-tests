include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//mod3"
}

inputs = {
  foo = dependency.mod1.outputs.mod1_file
  faa = dependency.mod2.outputs.mod2_file
}

dependency "mod1" {
  config_path = "../mod1"

  mock_outputs = {
    mod1_file = "mod1_file"
  }

}

dependency "mod2" {
  config_path = "../mod2"

  mock_outputs = {
    mod2_file = "mod2_file"
  }
}