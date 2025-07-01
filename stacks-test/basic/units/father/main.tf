resource "local_file" "file" {
  content     = " file"
  filename = "${path.module}/cluster_name.txt"
}


# create local file
resource "local_file" "test" {
  content  = "Hello, World!"
  filename = "${path.module}/test.txt"
}