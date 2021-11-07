resource "local_file" "requester" {
  content     = "requester"
  filename = "${path.module}/requester.txt"
}