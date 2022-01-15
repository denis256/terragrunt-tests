dependency "module2" {
  config_path = "../module2"

 mock_outputs = yamldecode(file(find_in_parent_folders("module2_mocks.yaml")))

}


inputs = {
  vpc_id = dependency.module2.outputs.vpc_id2
}