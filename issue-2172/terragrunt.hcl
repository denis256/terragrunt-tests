locals {
  is_restricted  = tobool(get_env("IS_RESTRICTED", "false"))
  decrypted_file = local.is_restricted ? file("file.txt") : sops_decrypt_file("not-existing-local-file.txt")
}
