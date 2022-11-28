terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.41.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-west-2"
}

resource "aws_s3_bucket" "validbucket1" {
  bucket        = "denis-x-2-my-log-bucket"
  logging {
    target_bucket = "${aws_s3_bucket.logbucket.id}"
    target_prefix = "log/"
  }
  # other required fields here
}

resource "aws_s3_bucket" "logbucket" {
  bucket        = "denis-x-my-log-bucket"
  acl           = "log-delivery-write"

  logging {
    target_bucket = "my-log-bucket"
    target_prefix = "log/"
  }
  # other required fields here
}