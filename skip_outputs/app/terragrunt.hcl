dependency "kubeaks" {
  config_path = "../module"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    host = "qwe"
  }
}


inputs = {
  cluster_name = dependency.kubeaks.outputs.host

}