remote_state {
  backend = "s3"
  config = {
    bucket                = "test-tg-123"
    key                   = "terraform.tfstate"
    region                = "us-west-2"
    assume_role = {
      role_arn            = "arn:aws:iam::123:role/s3-role-1"
      external_id        = "123"
      session_name = "qwe"
    }
    encrypt               = true
    dynamodb_table        = "admin-terraform-lock"
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
