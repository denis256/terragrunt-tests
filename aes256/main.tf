terraform {
  backend "s3" {}
}

resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name-1.txt"
}

resource "local_file" "file2" {
  content     = " file"
  filename = "${path.module}/cluster_name-2.txt"
}