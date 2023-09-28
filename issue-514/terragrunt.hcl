remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "test-s3-test-tg-123-8"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}