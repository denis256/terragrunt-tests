generate "provider" {
  path      = "terraform2.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF
    terraform {
      required_version = ">= 1.3.0"
    }
    EOF
}