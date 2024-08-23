

variable "val" {}

output "val" {
  value = "val: ${var.val}"
}