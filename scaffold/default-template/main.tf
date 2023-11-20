variable "vpc" {}
variable "replica_count" {}


resource "local_file" "config" {
  content     = "vpc: ${var.vpc} replica_count: ${var.replica_count}"
  filename = "${path.module}/conifg.txt"
}
