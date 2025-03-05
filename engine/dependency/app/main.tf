variable "data" {}

resource "local_file" "file" {
  content     = var.data
  filename = "${path.module}/file.txt"
}

output "app_data" {
  value = var.data
}