
variable "environment" {}

resource "local_file" "pass_file" {
  content     = "environment: ${var.environment}"
  filename = "${path.module}/file.txt"
}
