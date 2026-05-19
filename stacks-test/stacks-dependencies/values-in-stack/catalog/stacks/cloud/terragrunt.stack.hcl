unit "provider" {
  source = "../../units/${values.cloud}-provider"
  path   = "provider"
}

unit "consumer" {
  source = "../../units/consumer"
  path   = "consumer"

  autoinclude {
    dependency "provider" {
      config_path = unit.provider.path

      mock_outputs_allowed_terraform_commands = ["validate", "plan"]
      mock_outputs = {
        val = "fake-${values.cloud}-val"
      }
    }

    inputs = {
      val   = dependency.provider.outputs.val
      cloud = values.cloud
    }
  }
}
