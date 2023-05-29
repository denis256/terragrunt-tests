output "result" {
  value = "module2"
}

resource "local_file" "file" {
  content     = "module2"
  filename = "module2.txt"
}