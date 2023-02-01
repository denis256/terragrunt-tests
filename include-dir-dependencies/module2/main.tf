resource "local_file" "module2" {
  content     = "module2"
  filename = "${path.module}/module2.txt"
}
