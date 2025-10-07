
variable "common_data" {}

output "eventbridge_bus_name" {
  value = "admin-real-${var.common_data}"
}

