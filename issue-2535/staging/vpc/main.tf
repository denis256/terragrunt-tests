resource "local_file" "vpc" {
  content  = "vpc"
  filename = "${path.module}/vpc.txt"
}