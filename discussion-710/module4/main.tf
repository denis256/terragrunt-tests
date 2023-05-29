output "result" {
  value = "module4"
}

resource "local_file" "file" {
  content     = "module4"
  filename = "module4.txt"
}