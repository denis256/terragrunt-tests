include {
  path = find_in_parent_folders()
}
dependency "app_service_plan01" {
  config_path = "../module"
  mock_outputs = {
    asp_id = "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/mockrg/providers/Microsoft.Web/serverfarms/mockasp"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
  mock_outputs_merge_strategy_with_state = "true"
}

inputs = {
  fa_service_plan_id = dependency.app_service_plan01.outputs.asp_id
}