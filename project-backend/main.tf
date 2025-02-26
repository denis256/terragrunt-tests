variable "env" {}

output "data" {
  value = "backend ${var.env}"
}