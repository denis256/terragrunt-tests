terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.8.0"
    }
  }

  required_version = "> 0.15"
}

provider "aws" {

}

resource "aws_s3_bucket" "invalid" {
  bucket = "example-corp-assets"
}
