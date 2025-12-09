# App module
resource "local_file" "app" {
  content  = "app-config"
  filename = "${path.module}/app.txt"
}

output "app_url" {
  value = "https://app.example.com"
}
