variable "val" {
  type        = string
  description = "Value received from the provider unit"
}

variable "env" {
  type        = string
  description = "Environment name received via local.env from the stack file"
}

resource "local_file" "marker" {
  content  = "env=${var.env} val=${var.val}"
  filename = "${path.module}/input.txt"
}

output "received_val" {
  value = var.val
}

output "env" {
  value = var.env
}
