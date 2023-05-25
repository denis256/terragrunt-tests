output data {
  value = "module1"
}

resource "local_file" "file" {
  content         = "test1"
  filename        = "test1.txt"
  file_permission = "0644"
}