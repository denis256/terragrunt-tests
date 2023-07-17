terraform {
  source = "."
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
    provider "kubernetes" {
        insecure = true
    }
    EOF
}