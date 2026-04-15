variable "project_name" {
  type = string
}

variable "billing_account" {
  type    = string
  default = "000000-000000-000000"
}

resource "null_resource" "project" {
  triggers = {
    project_name    = var.project_name
    billing_account = var.billing_account
  }
}

output "project_id" {
  value = "prj-${var.project_name}"
}

output "project_number" {
  value = "123456789"
}
