remote_state {
  backend = "s3"
  config = {
    bucket         = "denis-test-tf-state2222"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    dynamodb_table = "denis-test-table"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
}