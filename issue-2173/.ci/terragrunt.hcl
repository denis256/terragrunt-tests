terraform {
  before_hook "terraform_lock" {
    commands = ["init"]
    execute  = ["rm", "-f", ".terraform.lock.hcl"]
  }

  after_hook "terraform_lock" {
    commands = concat(get_terraform_commands_that_need_locking(), ["init"])
    execute  = ["rm", "-f", "${get_terragrunt_dir()}/.terraform.lock.hcl"]
  }
}