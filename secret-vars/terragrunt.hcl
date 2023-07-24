terraform {
  source = "."
  before_hook "decrypt_vars" {
    commands = get_terraform_commands_that_need_vars()
    execute  = ["bash", "-c", "sops -d encrypted-vars.tfvars.enc > decrypted-vars.tfvars"]
  }

  extra_arguments "decrypted_vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      "decrypted-vars.tfvars"
    ]
  }
}