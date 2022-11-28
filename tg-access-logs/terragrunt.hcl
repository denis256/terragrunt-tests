remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    encrypt = true
    bucket = "tf-access-logs-denis-8"
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "tf-access-logs-denis-8"
    enable_lock_table_ssencryption = true
    accesslogging_bucket_name = "tf-access-logs-denis-8-logs"
    accesslogging_target_prefix = ""

    bucket_sse_kms_key_id          = "arn:aws:kms:us-west-2:372460975578:key/752a1294-9b58-4123-b9ae-8e46431fcf45"
  }
}
