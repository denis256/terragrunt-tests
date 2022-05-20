

resource "local_file" "file" {
  content     = " env 1"
  filename = "${path.module}/cluster_name.txt"
}