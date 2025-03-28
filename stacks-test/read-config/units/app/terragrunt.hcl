
locals {
  stack_data = read_terragrunt_config(find_in_parent_folders("terragrunt.stack.hcl"))
}

inputs = {
  data = "project_bucket: ${local.stack_data.local.project_bucket} app1: ${local.stack_data.unit.app1.values.deployment}"

}