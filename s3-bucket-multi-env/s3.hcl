# load S3 specific configs
locals {
  s3_config = read_terragrunt_config("s3_config.hcl")
}

# common S3 configurations
remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    encrypt = true
    bucket = local.s3_config.inputs.bucket
    key = "terraform.tfstate3"
    region = local.s3_config.inputs.region
    dynamodb_table = local.s3_config.inputs.bucket
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
