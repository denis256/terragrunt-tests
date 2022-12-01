resource "local_file" "app1" {
  content     = "app"
  filename = "${path.module}/app.txt"
}
