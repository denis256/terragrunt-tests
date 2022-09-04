
variable "i1" {}

variable "i2" {}

resource "local_file" "file1" {
  content     = "file ${var.i1}"
  filename = "${path.module}/file1.txt"
}

resource "local_file" "file2" {
  content     = "file ${var.i2}"
  filename = "${path.module}/file2.txt"
}