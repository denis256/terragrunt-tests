resource "local_file" "app3" {
  content     = "app"
  filename = "${path.module}/app.txt"
}
