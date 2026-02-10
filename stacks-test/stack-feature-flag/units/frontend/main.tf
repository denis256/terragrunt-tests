variable "app_name" {
  type = string
}

variable "api_endpoint" {
  type = string
}

output "app_url" {
  value = "https://${var.app_name}.app.local"
}

output "api_endpoint" {
  value = var.api_endpoint
}
