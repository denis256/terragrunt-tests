variable "ecr_url" {}

resource "local_file" "file" {
  content  = "${var.ecr_url}"
  filename = "${path.module}/file.txt"
}
