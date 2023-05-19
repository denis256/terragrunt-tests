
variable "content" {}

resource "local_file" "file" {
  content     = var.content
  filename = "${path.module}/info.txt"
}

output "output_file" {
  value = local_file.file.filename
}
