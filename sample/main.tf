resource "local_file" "file" {
  content     = "test"
  filename = "${path.module}/file2.txt"
}

