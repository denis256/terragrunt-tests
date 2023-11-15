variable "fileName" {}

resource "local_file" "file1" {
  content     = "file1"
  filename = "${path.module}/${var.fileName}"
}

