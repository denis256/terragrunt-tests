provider "aws" {
  region = "us-west-2"
}

# Example list of bucket names - replace with actual bucket names in your account
variable "bucket_names" {
  default = [
    "test-denis-tf-2024-1",
    "test-denis-tf-2024-10",
    "test-denis-tf-2024-11",
    "test-denis-tf-2024-12",
    "test-denis-tf-2024-13",
    "test-denis-tf-2024-14",
    "test-denis-tf-2024-15",
    "test-denis-tf-2024-16",
    "test-denis-tf-2024-17",
    "test-denis-tf-2024-18",
    "test-denis-tf-2024-19",
    "test-denis-tf-2024-2",
    "test-denis-tf-2024-20",
    "test-denis-tf-2024-21",
    "test-denis-tf-2024-3",
    "test-denis-tf-2024-30",
    "test-denis-tf-2024-4",
    "test-denis-tf-2024-5",
    "test-denis-tf-2024-6",
    "test-denis-tf-2024-7",
    "test-denis-tf-2024-8"
  ]
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
