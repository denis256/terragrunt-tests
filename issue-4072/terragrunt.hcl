locals {
  file = sops_decrypt_file("secrets.yaml")
}