remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "test-s3-test-tg-2023-07-03"
    key = "module.tfstate"
    region = "us-west-2"
  }
}
