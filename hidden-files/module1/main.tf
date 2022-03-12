
resource "local_file" "module_file" {
  content         = "module file work"
  filename        = "module.txt"
  file_permission = "0644"
}
