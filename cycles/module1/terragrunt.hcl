dependency "module2" {
  config_path = "../module2"

  mock_outputs = yamldecode(file(find_in_parent_folders("module2_mocks.yaml")))

}
