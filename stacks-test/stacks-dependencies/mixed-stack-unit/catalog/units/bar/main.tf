variable "val_from_stack" {
  type        = string
  description = "Value received from the unit inside stack foo"
}

variable "val_from_unit" {
  type        = string
  description = "Value received from sibling unit baz"
}

resource "local_file" "marker" {
  content  = "stack=${var.val_from_stack} unit=${var.val_from_unit}"
  filename = "${path.module}/input.txt"
}

output "received_from_stack" {
  value = var.val_from_stack
}

output "received_from_unit" {
  value = var.val_from_unit
}
