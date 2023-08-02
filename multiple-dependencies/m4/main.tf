resource "local_file" "file" {
  content     = "password file 666"
  filename = "${path.module}/file.txt"
}

output "sensitive_file" {
  value = local_file.file.filename
}