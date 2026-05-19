variable "val" {
  type        = string
  description = "Value received from the cloud-specific provider unit"
}

variable "cloud" {
  type        = string
  description = "Which cloud this consumer was generated for"
}

resource "local_file" "marker" {
  content  = "cloud=${var.cloud} val=${var.val}"
  filename = "${path.module}/input.txt"
}

output "received_val" {
  value = var.val
}

output "cloud" {
  value = var.cloud
}
