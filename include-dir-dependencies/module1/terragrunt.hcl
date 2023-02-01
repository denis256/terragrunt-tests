
terraform {
  extra_arguments "var_file" {
    commands = [
      "apply",
      "plan",
      "import",
    ]
    required_var_files = ["${get_env("TF_WORKSPACE")}.tfvars"]
  }
}

