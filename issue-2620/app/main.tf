resource "local_file" "file" {
  content     = var.data
  filename = "${path.module}/file.txt"
}
