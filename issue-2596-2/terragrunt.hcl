terraform {
    source = "tfr:///terraform-aws-modules/vpc/aws?version=3.5.0"

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

inputs = {
  enable_classiclink = ""
  enable_classiclink_dns_support = ""
  enable_classiclink = ""
}