variable "project_id" {
  type = string
}

variable "network_name" {
  type    = string
  default = "main"
}

resource "null_resource" "network" {
  triggers = {
    project_id   = var.project_id
    network_name = var.network_name
  }
}

output "network_id" {
  value = "net-${var.network_name}"
}

output "network_self_link" {
  value = "projects/${var.project_id}/global/networks/${var.network_name}"
}
