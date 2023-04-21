provider "aws" {
  region  = "us-east-12"
  profile = "test-profile"
}


terraform {
  backend "s3" {
    encrypt = true
    bucket = "test-bucket"
    dynamodb_table = "test-ddb"
    region = "us-east-1"
    key = "terraform.tfstate"
  }
}

