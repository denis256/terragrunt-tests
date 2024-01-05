terraform {
  backend "s3" {}
}

resource "local_file" "file" {
  content     = " file "
  filename = "${path.module}/cluster_name.txt"
}

output "file_name" {
  value = local_file.file.filename
}
