variable "project_id" {
  type = string
}

variable "role" {
  type    = string
  default = "roles/viewer"
}

variable "member" {
  type = string
}

resource "null_resource" "iam_binding" {
  triggers = {
    project_id = var.project_id
    role       = var.role
    member     = var.member
  }
}

output "iam_binding_id" {
  value = "${var.project_id}/${var.role}/${var.member}"
}
