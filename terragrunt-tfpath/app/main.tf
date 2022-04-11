resource "local_file" "file" {
  content     = "app"
  filename = "${path.module}/app.txt"
}

output "sensitive_file" {
  value = local_file.file.filename
}