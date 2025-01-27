

resource "local_file" "file" {
  content     = "file"
  filename = "${path.module}/file.txt"
}


output "file" {
  value = local_file.file.filename
}
