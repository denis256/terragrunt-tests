resource "local_file" "file" {
  content     = "test file"
  filename = "${path.module}/file.txt"
}

output "file_name" {
  value = local_file.file.filename
}