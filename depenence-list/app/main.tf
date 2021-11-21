resource "local_file" "app" {
    content     = "app"
    filename = "${path.module}/app.txt"
}
