resource "local_file" "file" {
  content  = "app"
  filename = "${path.module}/app.txt"
}
