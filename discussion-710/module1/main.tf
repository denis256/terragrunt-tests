output "result" {
  value = "module1"
}

resource "local_file" "file" {
  content     = "module1"
  filename = "module1.txt"
}