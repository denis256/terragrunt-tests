terraform {
  before_hook "before_hook" {
    commands     = get_terraform_commands_that_need_vars()
    execute      = ["./get_vars_file.sh"]  # render file tmp_vars.tfvars
  }

  extra_arguments "var-file" {
    commands  = get_terraform_commands_that_need_vars()
    # use pre-rendered file tmp_vars.tfvars
    arguments = ["-var-file", "/tmp/tmp_vars.tfvars"]
  }
}