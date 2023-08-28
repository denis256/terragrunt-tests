terraform {
  backend "s3" {
    bucket = "test-s3-test-tg-123-1"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}