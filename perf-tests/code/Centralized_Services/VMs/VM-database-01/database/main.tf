variable "vm_uuid" {
    type = string
}

variable "db_name" {
    type = string
}

variable "db_hostname" {
    type = string
}


output "db_hostname" {
    value = var.db_hostname
}

output "db_name" {
    value = var.db_name
}

output "db_password" {
    value = "p@ssword01"
}