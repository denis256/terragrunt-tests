locals {
  api_token = run_cmd("./key.sh", "--terragrunt-non-interactive")
}

terraform {
  extra_arguments "env_vars" {
    commands = ["apply", "plan"]

    env_vars = {
      TF_VAR_value = local.api_token
    }
  }
}