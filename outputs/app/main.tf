
variable "content" {
  type = string
}

resource "local_file" "file" {
  content     = " content: ${var.content}"
  filename = "${path.module}/file.txt"
}

