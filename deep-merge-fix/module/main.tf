resource "local_file" "module" {
  content     = "module"
  filename = "${path.module}/module.txt"
}