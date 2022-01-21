locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env = local.environment_vars.locals.environment

  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  region = local.region_vars.locals.aws_region

  region_path = find_in_parent_folders("${local.region}")
  name = "${local.region_path}/${local.env}"

  test = run_cmd("echo", "evaluated name: ", "${local.name}")

}