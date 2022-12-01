remote_state {
  backend  = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    encrypt                        = true
    bucket                         = "tf-access-logs-denis-71"
    key                            = "terraform.tfstate"
    region                         = "us-west-2"
    dynamodb_table                 = "tf-access-logs-denis-71"
    skip_bucket_ssencryption = true
    accesslogging_bucket_name      = "tf-access-logs-denis-71-logs"
    #bucket_sse_algorithm           = "AES256"

    accesslogging_bucket_tags = {
    }

    #    bucket_sse_algorithm = "aws:kms"
    #    bucket_sse_kms_key_id = "arn:aws:kms:us-west-2:372460975578:key/9b58-4123-b9ae-8e46431fcf45"

  }
}
