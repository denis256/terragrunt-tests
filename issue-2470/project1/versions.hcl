locals {
  required_version = ">= 1.2.9"

  required_providers = <<-EOT
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.32"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  EOT
}