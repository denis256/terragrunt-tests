provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "test-denis-2024-example-bucket-name"

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}

