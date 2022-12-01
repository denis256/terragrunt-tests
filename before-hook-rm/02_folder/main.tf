resource "local_file" "app2" {
  content     = "app"
  filename = "${path.module}/app.txt"
}
