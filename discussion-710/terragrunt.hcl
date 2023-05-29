terraform {

  extra_arguments "generate_plan_binary" {
    commands  = ["plan"]
    arguments = [
      "--out=${get_repo_root()}/discussion-710/plan/${basename(get_terragrunt_dir())}.plan.bin"
    ]
  }


}