locals {
  required_version = ">= 1.2.9"

  required_providers = <<-EOT
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.6.6"
    }

  EOT
}