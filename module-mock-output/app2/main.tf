variable "content" {
}

resource "local_file" "content" {
  content     = "Pass file: ${var.content}"
  filename = "content.txt"
}

output "file" {
  value = local_file.content.filename
}
