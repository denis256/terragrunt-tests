resource "local_file" "foo" {
  content     = "bar"
  filename = "${path.module}/file.txt"
}