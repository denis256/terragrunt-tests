dependency "unique_id" {
  config_path = format("%s/%s/shared/unique-id", get_path_to_repo_root(), get_path_from_repo_root())

  mock_outputs_allowed_terraform_commands = ["validate"]

  mock_outputs = {
    id = "000000"
  }
}