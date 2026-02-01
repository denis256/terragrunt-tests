remote_state {
  backend = "s3"
  config = {
    bucket         = "denis-2026-my-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "my-lock-table"
    use_lockfile = true
  }
}