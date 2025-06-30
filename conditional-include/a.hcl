dependency "module2" {
  count       = local.enable_aks_log_diagnostics ? 1 : 0
  config_path = "../module2"
  mock_outputs = {
    attribute = "mock attribute"
    hello     = "mock hello"
  }
  mock_outputs_allowed_terraform_commands = ["validate"]
  skip_outputs                            = true
}
