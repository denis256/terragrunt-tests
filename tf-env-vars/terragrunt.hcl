terraform {
  extra_arguments "env_var" {
    commands = [
      "init",
      "apply",
    ]

    env_vars = {
      TF_VAR_qwe = "123"
    }
  }
}