terraform {
  source = ".//"
}

include "root" {
  path = find_in_parent_folders()
}

dependency "module_b" {
  config_path = "../module-b"
}

inputs = {
  test_var = dependency.module_b.outputs.test_output
  test_var_2 = dependency.module_b.inputs.test_var
}