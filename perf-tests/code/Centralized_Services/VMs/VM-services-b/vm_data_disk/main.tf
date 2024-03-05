variable "rg" {
    type = string
}

variable "vm_name" {
    type = string
}

output "datadisk_id" {
    value = "some_value_for_${var.vm_name}_datadisk"
}
