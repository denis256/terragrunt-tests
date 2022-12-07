
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "s3-test-tg-2377-2"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-test-tg-2377-2"
    enable_lock_table_ssencryption = true


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
