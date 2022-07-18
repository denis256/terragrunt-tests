
variable "data" {}

resource "local_file" "file" {
  content     = "data: ${var.data}"
  filename = "${path.module}/file.txt"
}

output "output_file" {
  value = local_file.file.filename
}