locals {
  source = "."
}

terraform {
  source = local.source

  after_hook "copy_common_tf_to_source" {
    commands = ["init"]
    execute = ["bash", "-c", "cp ${get_terragrunt_dir()}/../_base_modules/*.common.tf ."]
    // execute = ["cp", "${get_terragrunt_dir()}/../_base_modules/*.common.tf", "."]
  }
}