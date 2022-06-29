terraform {
  source = "."

  error_hook "error_hook_1" {
    commands = ["apply"]
    execute  = ["echo", " **** resource group is exists *** "]
    on_errors = [
      "azurerm_resource_group", # how to set regex statement
      ".*subscriptions.*resourceGroups.*test.*",
      "No such file or directory",
     # ".*not-existing-file.*"
    ]
  }
}

inputs = {
  location = "Southeast Asia"
  name = "test"
}
