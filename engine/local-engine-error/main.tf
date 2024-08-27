
variable "value" {}

resource "local_file" "test" {
  content  = "Hello, World! ${var.value}"
  filename = "${path.module}/test.txt"


}