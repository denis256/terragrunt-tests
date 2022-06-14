resource "local_file" "file" {
  content  = "module2"
  filename = "${path.module}/module2.txt"
}
