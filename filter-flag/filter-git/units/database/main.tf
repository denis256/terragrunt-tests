# Database module
resource "local_file" "database" {
  content  = "database-config"
  filename = "${path.module}/database.txt"
}

output "db_endpoint" {
  value = "db.example.com"
}
