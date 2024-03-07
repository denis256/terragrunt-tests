dependency "kubernetes" {
  config_path = "../kubernetes"

  mock_outputs = {
    kubernetes_url = ""
  }

  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate", "destroy"]
}

inputs = {
  kubernetes_url = dependency.kubernetes.outputs.kubernetes_url
}