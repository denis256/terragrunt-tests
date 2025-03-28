locals {
  stack_data = read_terragrunt_config(find_in_parent_folders("terragrunt.stack.hcl"))
  read_values = read_terragrunt_config("terragrunt.values.hcl")
}

inputs = {
  project_bucket          = local.stack_data.local.project_bucket
  stack_values_deployment = local.stack_data.unit.app1.values.deployment
  values_project          = local.read_values.project
}