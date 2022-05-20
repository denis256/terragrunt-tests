
resource "local_file" "file" {
  content     = " env 2"
  filename = "${path.module}/cluster_name.txt"
}