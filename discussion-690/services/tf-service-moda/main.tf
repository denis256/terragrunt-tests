
resource "local_file" "file" {
  content     = "moda"
  filename = "${path.module}/moda.txt"
}
