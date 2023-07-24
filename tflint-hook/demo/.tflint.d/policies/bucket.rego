package tflint

deny_invalid_s3_bucket_name[issue] {
  buckets := terraform.resources("aws_s3_bucket", {"bucket": "string"}, {})
  name := buckets[_].config.bucket
  not startswith(name.value, "example-com-")

  issue := tflint.issue(`Bucket names should always start with "example-com-"`, name.range)
}