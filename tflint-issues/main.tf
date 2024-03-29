terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
  required_version = ">= 1.2.7"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

}