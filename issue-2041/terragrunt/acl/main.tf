variable "value" {}

resource "local_file" "file" {
  content     = "value: ${var.value}"
  filename = "${path.module}/file.txt"
}
