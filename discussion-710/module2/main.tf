output "result" {
  value = "module2"
}

resource "local_file" "file" {
  content     = "module2"
  filename = "module2.txt"
}

output "file_name" {
  value = local_file.file.filename
}