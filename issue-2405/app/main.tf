variable "vpc_id" {}

variable "private_subnets" {}


resource "local_file" "file2" {
  content     = "${var.vpc_id} ${var.private_subnets}"
  filename = "file.txt"
}
