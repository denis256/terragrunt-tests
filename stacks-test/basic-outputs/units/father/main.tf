resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name.txt"
}

output "value" {
  value = local_file.file.filename
}


output "output" {
  value = "father"
}