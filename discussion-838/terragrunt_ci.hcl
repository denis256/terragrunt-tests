remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket   = "your-bucket-name"
    key      = "your-key"
    region   = "your-region"
    role_arn = "your-assume-role-arn"
  }
}
