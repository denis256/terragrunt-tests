# terraform {
#   backend "s3" {}
#   encryption {
#     key_provider "aws_kms" "myprovider" {
#       kms_key_id = "1234abcd-12ab-34cd-56ef-1234567890ab"
#     }
#   }
# }


resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name-1.txt"
}

resource "local_file" "file2" {
  content     = " file"
  filename = "${path.module}/cluster_name-2.txt"
}