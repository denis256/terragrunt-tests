variable "content" {}

variable "file" {
  default = "file.txt"
}

resource "local_file" "file" {
  content         = var.content
  filename        = var.file
  file_permission = "0644"
}

output "config_file" {
  value     = local_file.file.filename
}