dependency "grafana" {
  config_path = "../grafana"

  mock_outputs = {
    grafana_admin_fqdn = ""
  }

  mock_outputs_merge_strategy_with_state  = "shallow"
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate", "destroy"]
}

inputs = {
  config_url = dependency.grafana.outputs.grafana_admin_fqdn
  kubernetes_url = dependency.grafana.outputs.kubernetes_url
}