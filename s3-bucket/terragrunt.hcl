remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "test-s3-test-tg-123-1-666123"
    //bucket = "test"
    key    = "terraform2.tfstate"
    region = "us-west-2"
    // region = "us-west-2"

  }
}

terraform {
  source = "."
}