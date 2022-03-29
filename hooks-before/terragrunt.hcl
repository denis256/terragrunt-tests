terraform {

  after_hook "hook" {
    commands = ["terragrunt-read-config"]
    execute = ["echo", "terragrunt-read-config"]
  }
}

locals {
  init = run_cmd("bash", "init.sh")
}