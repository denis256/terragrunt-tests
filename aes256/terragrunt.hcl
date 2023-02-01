remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "denis-s3-test-tg-12"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "denis-s3-test-tg-12"
    enable_lock_table_ssencryption = true
    bucket_sse_algorithm = "AES256"

    s3_bucket_tags = {
      owner = "terragrunt integration test"
      name = "Terraform state storage"
    }

    dynamodb_table_tags = {
      owner = "terragrunt integration test"
      name = "Terraform lock table"
    }
  }
}
