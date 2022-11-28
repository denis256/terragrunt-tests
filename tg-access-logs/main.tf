resource "local_file" "file" {
  content     = "file1"
  filename = "${path.module}/cluster_name_1.txt"
}

resource "local_file" "file2" {
  content     = "file2"
  filename = "${path.module}/cluster_name_2.txt"
}

resource "local_file" "file3" {
  content     = "file2"
  filename = "${path.module}/cluster_name_3.txt"
}