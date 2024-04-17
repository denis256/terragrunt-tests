locals {
  stage_vars          = read_terragrunt_config(find_in_parent_folders("stage.hcl"))
  resource_group_name = local.stage_vars.locals.resource_group_name
  stage_name = local.stage_vars.locals.stage_name
}

inputs = {
  resource_group_name = local.resource_group_name
  stage_name = local.stage_name
}