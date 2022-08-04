variable "value" {
  type = string
}
resource "local_file" "file" {
  content     = var.value
  filename = "${path.module}/txt.txt"
}
