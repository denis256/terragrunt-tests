locals {
  env_name = split("/", path_relative_to_include())[0]
}

inputs = {
  env_name= local.env_name
}

# Configure S3 and DynamoDB
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "environment-${local.env_name}"
    key            = "${local.env_name}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-statefile-locks-${local.env_name}"
  }
}
