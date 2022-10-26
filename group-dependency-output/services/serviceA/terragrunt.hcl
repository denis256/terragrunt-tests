locals {
  unique_id_vars    = read_terragrunt_config(find_in_parent_folders("unique-id.hcl"))
  unique_id         = local.unique_id_vars.dependency.unique_id.outputs.id
}

#dependency "unique_id" {
#  config_path = format("%s/group-dependency-output/shared/unique-id", get_path_to_repo_root())
#
#  mock_outputs_allowed_terraform_commands = ["validate"]
#
#  mock_outputs = {
#    id = "000000"
#  }
#}

inputs = {
  unique_id = local.unique_id

  #unique_id = dependency.unique_id.outputs.id
}