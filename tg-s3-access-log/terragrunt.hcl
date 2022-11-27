remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "denis-tg-test-2022-11-20-t6"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    skip_bucket_ssencryption = true
    dynamodb_table = "denis-tg-test-2022-11-20-t6"
    accesslogging_bucket_name      = "denis-tg-test-2022-11-20-access-t6"
    accesslogging_target_prefix    = "prefix"
  }
}