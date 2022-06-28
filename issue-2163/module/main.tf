variable "fa_service_plan_id" {}
resource "azurerm_windows_function_app" "function_app" {
  app_settings = "app_settings"
  location = "location"
  name = "test-azf"
  resource_group_name = "resource_group_name"
  service_plan_id = var.fa_service_plan_id
}