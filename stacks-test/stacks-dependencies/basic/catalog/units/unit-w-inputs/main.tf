# Unit that consumes outputs from another unit via dependency.
# This simulates an app module that depends on a VPC module.

variable "val" {
  type        = string
  description = "Value received from the dependency unit"
}

resource "local_file" "input_marker" {
  content  = "Received: ${var.val}"
  filename = "${path.module}/input.txt"
}

output "received_val" {
  value = var.val
}
