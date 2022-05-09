
variable "value" {}

resource "local_file" "provider_file" {
  content         = "value:  ${var.value}"
  filename        = "value.txt"
  file_permission = "0644"
}