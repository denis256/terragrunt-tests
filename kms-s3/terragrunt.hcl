remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "s3-test-tg-2023-1"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "s3-test-tg3"
    enable_lock_table_ssencryption = true

    #bucket_sse_algorithm = "AES256"
    bucket_sse_kms_key_id          = "alias/dedicated-test-key"

  }
}
