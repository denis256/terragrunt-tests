terraform {
  backend "s3" {}
}


resource "local_file" "pass_file" {
  content     = "file"
  filename = "${path.module}/file.txt"
}
