resource "local_file" "foo" {
  content  = "iam-policies"
  filename = "${path.module}/file.json"
}