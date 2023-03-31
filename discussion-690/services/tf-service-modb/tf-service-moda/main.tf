
resource "local_file" "file" {
  content     = "modb"
  filename = "${path.module}/modb.txt"
}
