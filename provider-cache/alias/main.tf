
provider "aws" {
  alias  = "other_account"
  region = "eu-central-1"
}

provider "aws" {
  region = "us-east-1" # You can choose the region that suits you
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "terragrunt-test-3324323423"

  tags = {
    Name        = "My Bucket"
    Environment = "Test"
  }
}

resource "aws_s3_bucket" "my_bucket_2" {
  bucket = "terragrunt-test-3324323423-2"
  provider  = aws.other_account

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