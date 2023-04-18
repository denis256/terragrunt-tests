
remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "denis-s3-test-2023"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "denis-s3-test-2023"
  }
}
