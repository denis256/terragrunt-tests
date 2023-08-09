terraform {
  source          = "."
  include_in_copy = [".tflint.d/**"]
  before_hook "tflint" {
    commands = ["validate", "apply",  "--terragrunt-external-tflint"]
    execute  = ["tflint"]
    # "--terragrunt-external-tflint"
    # ,  "--minimum-failure-severity=error"
    #  "--terragrunt-external-tflint"
    # "--terragrunt-external-tflint",
    # "--minimum-failure-severity=error"
  }

  extra_arguments "test" {
    commands = get_terraform_commands_that_need_vars()
    env_vars = {
      TF_VAR_custom_var = "Im set in extra_arguments env_vars"
      TF_VAR_name = "corp-1"
    }

    arguments = [
     # "-var=name=example-com-qwe"
    ]
  }
}

inputs = {
  xyz = "abc"
  //name = "example-corp-assets"
}