variable "db_name" {
  type = string
}

output "db_endpoint" {
  value = "${var.db_name}.db.local"
}
