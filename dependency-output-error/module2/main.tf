output data {
  value = "module2"
}

resource "local_file" "file" {
  content         = "test2"
  filename        = "test2.txt"
  file_permission = "0644"
}