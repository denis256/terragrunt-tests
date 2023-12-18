remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket                = "test-tg-2023-01"
    key                   = "denis-1-terraform.tfstate"
    region                = "eu-central-1"
    assume_role = {
      role_arn            = get_aws_caller_identity_arn()
      external_id        = "123"
      session_name = "qwe"
    }
    encrypt               = true
    disable_bucket_update = true
    s3_bucket_tags = {
      owner = "terragrunt"
      name  = "Terraform state storage"
    }
    dynamodb_table_tags = {
      owner = "terragrunt"
      name  = "Terraform lock table"
    }
  }
}
