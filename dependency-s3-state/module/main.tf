

resource "local_file" "file" {
  content     = " file module"
  filename = "${path.module}/cluster_name.txt"
}

output "output_file" {
  value = local_file.file.filename
}