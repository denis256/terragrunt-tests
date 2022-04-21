
variable "qwe" {}

resource "local_file" "foo" {
  content     = var.qwe
  filename = "${path.module}/file.txt"
}