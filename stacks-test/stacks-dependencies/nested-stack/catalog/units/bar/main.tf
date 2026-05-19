variable "val" {
  type        = string
  description = "Value received from the nested provider unit"
}

resource "local_file" "marker" {
  content  = "Received: ${var.val}"
  filename = "${path.module}/input.txt"
}

output "received_val" {
  value = var.val
}
