terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v3.6.0"
}

inputs = {
  bucket = "test-bucket-1"
  acl    = "private"
  versioning = {
    enabled = true
  }
}