variable "env" {}

output "data" {
  value = "frontend ${var.env}"
}