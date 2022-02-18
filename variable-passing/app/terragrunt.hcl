
locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl"))
}


inputs = {
  instance_id = local.common.locals.instance_id
}


terraform {
  extra_arguments "plan" {
    commands = [
      "plan",
    ]
    arguments = [
      "-out=${get_terragrunt_dir()}/plan.out"
    ]
  }
}

