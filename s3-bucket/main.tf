terraform {
  backend "s3" {}
}

resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name.txt"
}

resource "local_file" "file2" {
  content     = " file2"
  filename = "${path.module}/cluster_name2.txt"
}