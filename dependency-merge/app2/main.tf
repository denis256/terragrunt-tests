
variable "bucket_policy_statements" {}

resource "local_file" "foo" {
  content     = var.bucket_policy_statements
  filename = "${path.module}/file.json"
}