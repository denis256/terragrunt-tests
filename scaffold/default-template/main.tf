variable "vpc" {

  description = "VPC to be used"
  default     = "default-vpc"

}
variable "replica_count" {
  default = "666"
}


resource "local_file" "config" {
  content  = "${var.project_name} vpc: ${var.vpc} replica_count: ${var.replica_count}"
  filename = "${path.module}/conifg.txt"
}
