provider "aws" {
  region = "us-east-2"
}

# Example list of bucket names - replace with actual bucket names in your account
variable "bucket_names" {
  default = ["denis-test-us-east-2", "denis-test-us-east-2-2", "denis-test-us-east-2-3"] # Add as many bucket names as possible
}

# Data source to get information on each S3 bucket
data "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names)

  bucket = each.value
}

resource "null_resource" "api_call_trigger" {
  count = 100 # Large count to force frequent API calls

  triggers = {
    always_run = "${timestamp()}"
  }

  # This provisioner forces a refresh of the data sources on each apply
  provisioner "local-exec" {
    command = "echo Refreshing S3 bucket data sources"
  }

  depends_on = [data.aws_s3_bucket.buckets]
}
