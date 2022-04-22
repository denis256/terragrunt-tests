
variable "value_a" {}

variable "value_b" {}

resource "local_file" "foo" {
  content     = "${var.value_a}${var.value_b}"
  filename = "${path.module}/file.txt"
}