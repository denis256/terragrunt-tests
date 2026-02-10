variable "app_name" {
  type = string
}

variable "db_endpoint" {
  type = string
}

output "api_endpoint" {
  value = "${var.app_name}.api.local"
}

output "db_endpoint" {
  value = var.db_endpoint
}
