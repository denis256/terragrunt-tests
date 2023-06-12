terraform {
  extra_arguments "optional_vars" {
    commands = [
      "apply",
      "destroy",
      "plan",
    ]

    optional_var_files = [
      "default.tfvars"
    ]
  }
}