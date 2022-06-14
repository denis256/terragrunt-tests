resource "local_file" "file" {
  content  = "module1"
  filename = "${path.module}/module1.txt"
}
