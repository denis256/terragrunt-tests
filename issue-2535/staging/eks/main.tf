resource "local_file" "eks" {
  content  = "eks"
  filename = "${path.module}/eks.txt"
}