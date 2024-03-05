variable "rg" {
    type = string
}

variable "subnet_id" {
    type = string
}

variable "datadisk_id" {
    type = string
}

variable "vm_name" {
    type = string
}

output "vm_ip" {
    value = "1.2.3.4"
}

output "vm_uuid" {
    value = "${var.vm_name}_uuid"
}