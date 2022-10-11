inputs = {
  current_cli_args = get_terraform_cli_args()[1]
  current_command = get_terraform_command()
}

terraform {
  after_hook "after_hook" {
    commands     = ["destroy"]
    execute      = ["./cleanup",  get_terraform_cli_args()[1]]
  }
}