resource "local_file" "module3" {
  content     = "module3"
  filename = "${path.module}/module3.txt"
}
