include "root" {
  path = find_in_parent_folders()
}
locals {
  env              = "${get_env("ENV")}"
  aws_project_name = "${yamldecode(file("${get_repo_root()}/issue-2718/var/${get_env("ENV")}.tfvars"))}"
}
dependency "vpc_main" {
  config_path  = "../vpc"
  mock_outputs = {
    aws_subnet_public_output = {
      "${local.aws_project_name}-${local.env}-default-public-a" = {
        "id" = "subnet-00000000000000000"
      }
    }
    mock_outputs_merge_with_state           = true
    mock_outputs_allowed_terraform_commands = ["init", "refresh", "validate", "plan", "fmt", "apply"]
  }
}

inputs = {
  qwe = "123"
  aws_vpc_subnet_a_id = dependency.vpc_main.outputs.aws_subnet_public_output[format("%s-%s-default-public-a", local.aws_project_name, local.env)].id
}
