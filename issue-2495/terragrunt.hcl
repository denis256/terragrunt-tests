

terraform {

  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=master"


  extra_arguments "publish_vars" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "refresh",
      "output",
      "destroy"
    ]
    required_var_files = [
      "${get_parent_terragrunt_dir()}/common.tfvars",

    ]
  }
}