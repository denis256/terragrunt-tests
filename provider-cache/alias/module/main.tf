provider "aws" {
  alias  = "other_account"
  region = "eu-central-1"
}


resource "aws_s3_bucket" "my_bucket_2" {
  bucket = "terragrunt-test-module-2"
  provider  = aws.other_account

  tags = {
    Name        = "My Bucket"
    Environment = "Test"
  }
}
