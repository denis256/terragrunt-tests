variable "qwe" {}
resource "local_file" "file" {
  content     = "value = ${var.qwe}"
  filename = "${path.module}/app.txt"
}
