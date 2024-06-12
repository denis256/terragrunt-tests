dependency "resource-group" {
  config_path                             = "../module"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs_merge_strategy_with_state  = "shallow"

  mock_outputs = {
    rg_names = {
      scraping_concurrence_00 = "mock-rg"
      api_offre_prix_00       = "mock-rg"
    }
    rg_locations = {
      scraping_concurrence_00 = "mock-location"
      api_offre_prix_00       = "mock-location"
    }
  }
}

locals {
  environment_name = "test-666"
}

inputs = {
  environment                      = local.environment_name
  scraping_concurrence_00_name     = dependency.resource-group.outputs.rg_names["scraping_concurrence_00"]
  scraping_concurrence_00_location = dependency.resource-group.outputs.rg_locations["scraping_concurrence_00"]
  api_offre_prix_00_name           = dependency.resource-group.outputs.rg_names["api_offre_prix_00"]
  api_offre_prix_00_location       = dependency.resource-group.outputs.rg_locations["api_offre_prix_00"]
}