resource "local_file" "module3" {
  content     = "module2"
  filename = "${path.module}/module3.txt"
}
