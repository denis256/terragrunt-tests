
variable "resource_group_name" {}


variable "stage_name" {}


output "storage_account_name" {
  value = var.resource_group_name
}


output "stage_name" {
  value = var.stage_name
}