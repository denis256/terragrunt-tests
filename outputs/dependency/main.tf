resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name.txt"
}

output "cluster_name" {
  value = "${local_file.file.filename}"
}