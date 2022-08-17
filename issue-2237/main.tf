variable "subnet" {}

variable "vpc" {}

resource "local_file" "file" {
  content     = "app ${var.subnet} ${var.vpc}"
  filename = "${path.module}/app.txt"
}
