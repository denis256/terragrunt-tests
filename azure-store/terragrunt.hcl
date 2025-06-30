remote_state {
  backend = "azurerm"
  config = {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate149716"
    container_name       = "tfstate149716"
    key                  = "terraform.tfstate"
    subscription_id      = "123"
    tenant_id            = "456"
    location             = "eastus"
    access_tier          = "Hot"
    sku                  = "Standard_LRS"
    kind                 = "StorageV2"
  }
}