# Minimal module so the app unit is loadable. Accepts the input the stack generates.
variable "name" {
  type    = string
  default = ""
}

output "name" {
  value = var.name
}
