variable "data" {}

output "data" {
  value = "api ${var.data}"
}