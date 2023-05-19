variable "file_name" {}
variable "content" {}

resource "local_file" "file" {
  content     = var.content
  filename = "${path.module}/${var.file_name}"
}

output "output_file" {
  value = local_file.file.filename
}
