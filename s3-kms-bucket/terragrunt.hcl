remote_state {
  backend = "s3"
  config = {
    encrypt  = true
    bucket = "s3-test-denis-12"
    key = "terraform.tfstate"
    region = "us-east-1"

    #dynamodb_table = "s3-test-denis-9"
    #enable_lock_table_ssencryption = true
    #bucket_sse_algorithm = "AES256"

    #bucket_sse_algorithm = "aws:kms"
    #bucket_sse_kms_key_id  = "arn:aws:kms:us-east-1:087285199408:key/544b9b44-36fb-4371-ba09-a79904fd8ca7"

  }
}
