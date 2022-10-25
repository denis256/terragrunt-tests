dependency "custom-data-provider" {
  config_path = "./custom-data-provider"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    custom_data = "666"
  }
}

terraform {
  source = "../../terraform/modules/file-generator"
}

inputs = {
  content = dependency.custom-data-provider.outputs.custom_data
}