resource "local_file" "file" {
  content     = "module"
  filename = "${path.module}/module.txt"
}

output "sensitive_file" {
  value = local_file.file.filename
}