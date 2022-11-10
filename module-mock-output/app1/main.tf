variable "content" {
}

resource "local_file" "file" {
  content     = "file: ${var.content}"
  filename = "file.txt"
}

output "file" {
  value = local_file.file.filename
}
