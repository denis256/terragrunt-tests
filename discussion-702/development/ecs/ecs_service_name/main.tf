
variable "environment" {}

variable "pwd" {}

resource "local_file" "pass_file" {
  content     = "environment: ${var.environment}  pwd: ${var.pwd}"
  filename = "${path.module}/file.txt"
}
