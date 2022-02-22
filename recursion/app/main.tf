variable "x" {}

resource "local_file" "foo" {
  content     = var.x
  filename = "${path.module}/foo.txt"
}