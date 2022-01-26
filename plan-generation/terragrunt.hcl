terraform {
  extra_arguments "plan_file" {
    commands = [
      "plan",
    ]
    arguments = [
      "-out=${get_terragrunt_dir()}/tfplan.binary"
    ]
  }
  after_hook "after_hook_plan" {
    commands     = ["plan"]
    execute      = ["sh", "-c", "mkdir -p ${get_parent_terragrunt_dir()}/plans/${path_relative_to_include()}; terraform show -json tfplan.binary > ${get_parent_terragrunt_dir()}/plans/${path_relative_to_include()}/plan.json"]
  }
}
