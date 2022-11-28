remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "denis-tg-test-2022-11-20-access"
    key            = "terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "denis-tg-test-2022-11-20-access"
    accesslogging_bucket_name      = "denis-tg-test-2022-11-20-access-access"
    accesslogging_target_prefix    = "prefix"

  }
}