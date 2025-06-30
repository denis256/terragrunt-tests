terraform {

  extra_arguments "generate_plan_binary" {
    commands = ["plan"]
    arguments = [
      "--out=${get_repo_root()}/discussion-710/plan/${basename(get_terragrunt_dir())}.plan.bin"
    ]
  }

  after_hook "generate_plan_json" {
    commands = ["plan"]
    execute = [
      "bash", "-c",
      "terragrunt show -json ${get_repo_root()}/discussion-710/plan/${basename(get_terragrunt_dir())}.plan.bin  > ${get_repo_root()}/discussion-710/plan/${basename(get_terragrunt_dir())}.plan.bin.json"
    ]
  }

  before_hook "copy_plan" {
    commands = ["apply"]
    execute = [
      "bash", "-c",
      "cp ${get_repo_root()}/discussion-710/plan/${basename(get_terragrunt_dir())}.plan.bin terraform.tfplan"
    ]
    working_dir = get_terragrunt_dir()
  }

}