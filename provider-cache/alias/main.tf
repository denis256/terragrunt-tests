provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "other_account"
  region = "eu-central-1"
}

module "s3_module" {
  source = "./module"
}

resource "aws_s3_bucket" "my_bucket_1" {
  bucket = "terragrunt-test-module-1"
  provider  = aws.other_account

  tags = {
    Name        = "My Bucket"
    Environment = "Test"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "terragrunt-test-3"

  tags = {
    Name        = "My Bucket"
    Environment = "Test"
  }
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.my_bucket.arn
}