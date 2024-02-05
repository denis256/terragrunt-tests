remote_state {
  backend = "azurerm"
  config = {
    resource_group_name = "qwe"
    storage_account_name = "123"
    container_name = "666"
    key = "test"
    subscription_id = "123"
    tenant_id = "111"
  }
}