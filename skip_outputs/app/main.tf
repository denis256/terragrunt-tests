variable "cluster_name" {}

resource "local_file" "file" {
  content     = " file: ${var.cluster_name}"
  filename = "${path.module}/cluster_name.txt"
}
