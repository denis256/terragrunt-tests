dependency "global" {
  config_path = "${get_path_to_repo_root()}/issue-3310-v2/global"
  mock_outputs = {
    test = 1
  }
}

inputs = {
  test = dependency.global.outputs.test
}
