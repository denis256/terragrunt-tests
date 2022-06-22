terraform {
  backend "s3" {}
}

variable "output_file" {}

resource "local_file" "file" {
  content     = " output_file: ${var.output_file}"
  filename = "${path.module}/cluster_name.txt"
}
