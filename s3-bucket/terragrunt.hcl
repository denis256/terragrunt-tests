remote_state {
  backend = "s3"
  config = {
    encrypt = true
    //bucket = "test-s3-test-tg-123-1"
    bucket = "test-s3-test-tg-123-5"
    key = "terraform.tfstate"
    region = "us-east-1"
   // region = "us-west-2"

  }
}
