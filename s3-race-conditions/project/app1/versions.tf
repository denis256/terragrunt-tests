terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.25"
    }
  }

  required_version = ">= 1.0.0"
}