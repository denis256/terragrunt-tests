resource "local_file" "file" {
  content     = "222"
  filename = "${path.module}/file2.txt"
}

