dependency "dependency" {
  config_path = "../dependency"


  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    cluster_name = "cluster_name"
  }
}



inputs = {
  content = dependency.dependency.outputs.cluster_name
}