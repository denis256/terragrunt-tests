output "result" {
  value = "module3"
}

resource "local_file" "file" {
  content     = "module3"
  filename = "module3.txt"
}