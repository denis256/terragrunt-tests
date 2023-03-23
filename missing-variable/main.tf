variable "var" {}


resource "local_file" "file" {
  content     = " ${var.var}"
  filename = "${path.module}/cluster_name-1.txt"
}
