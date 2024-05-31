
locals {

  secret_vars = yamldecode(sops_decrypt_file("file2.enc.yaml"))
}