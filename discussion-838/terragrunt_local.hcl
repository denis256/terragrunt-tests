remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "your-local-bucket-name"
    key     = "your-local-key"
    region  = "your-local-region"
    profile = "your-local-aws-profile"
  }
}
