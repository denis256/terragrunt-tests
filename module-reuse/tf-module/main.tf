variable "file_name" {}
variable "content" {}


resource "local_file" "file" {
  content     = var.content
  filename = "${var.file_name}"
}