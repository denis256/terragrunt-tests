remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "test-denis-tf-2024-30"
    key            = "${path_relative_to_include()}/1-terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "test-denis-tf-2024-30"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


EOF
}