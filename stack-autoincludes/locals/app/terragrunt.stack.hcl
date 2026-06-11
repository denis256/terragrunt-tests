
locals {
  local_input = "000"
  mock_data = "mock-output-1"
}

unit "unit1" {
  source = "../units/unit-1"
  path   = "u1"

  autoinclude {

    dependency "dep1" {
      config_path = "${get_working_dir()}/../dep-1"
      mock_outputs_allowed_terraform_commands = ["plan"]

      mock_outputs = {
        data = local.mock_data
      }
    }

    inputs = {
      input = dependency.dep1.outputs.data
    }

  }

}

