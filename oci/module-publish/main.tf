terraform {
  required_version = ">= 1.10.0"
}

variable "name" {
  description = "Name included in the hello-world message."
  type        = string
  default     = "world"
}

output "message" {
  description = "Message returned by the OCI module."
  value       = "Hello, ${var.name}, from an OCI module!"
}
