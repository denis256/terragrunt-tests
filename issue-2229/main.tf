resource "local_file" "accepter" {
  content     = "accepter"
  filename = "${path.module}/accepter.txt"
}
