include "root" {
  path = find_in_parent_folders()
}

dependency "dependency" {
  config_path = "../dependency"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    output_file = "test-file.txt"
  }
}

inputs = {
  content = "data: ${dependency.dependency.outputs.output_file}"
}