resource "local_file" "file" {
  content     = "111"
  filename = "${path.module}/file111.txt"
}

