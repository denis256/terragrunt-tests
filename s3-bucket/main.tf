terraform {
  backend "s3" {}
}

resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name.txt"
}