variable "customer_gateway_tags" {}

resource "local_file" "file" {
  content     = "customer_gateway_tags = ${var.customer_gateway_tags}"
  filename = "${path.module}/file.txt"
}
