variable "secret_value" {}

resource "local_file" "write_secret_value" {
  content     = "secret_value: ${var.secret_value}"
  filename = "${path.module}/secret_value.txt"
}

