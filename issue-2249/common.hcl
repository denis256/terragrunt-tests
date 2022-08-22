terraform {
  before_hook "decrypt_states" {
    commands    = ["plan", "apply", "init", "import", "state", "destroy", "output"]
    execute     = ["bash", "-c", "echo 'decrypt_states' "]
    working_dir = "${get_parent_terragrunt_dir()}"
  }

  after_hook "encrypt_states" {
    commands     = ["plan", "apply", "init", "import", "state", "destroy", "output"]
    execute     = ["bash", "-c", "echo 'encrypt_states' "]
    working_dir  = "${get_parent_terragrunt_dir()}"
    run_on_error = true
  }
}