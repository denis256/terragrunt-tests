remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    encrypt = true
    bucket = "tf-access-logs-denis-1"
    key = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "tf-access-logs-denis-1"
    enable_lock_table_ssencryption = true
    accesslogging_bucket_name = "tf-access-logs-denis-1-logs"
  }
}
