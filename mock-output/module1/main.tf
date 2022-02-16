
variable "hello" {}

variable "attribute" {}

resource "local_file" "file" {
  content     = "hello: ${var.hello}  attribute: ${var.attribute}"
  filename = "${path.module}/file.txt"
}


