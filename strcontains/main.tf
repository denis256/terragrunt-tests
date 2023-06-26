variable "x" {}

resource "local_file" "file" {
  content     = " file: ${var.x}"
  filename = "${path.module}/x.txt"
}
