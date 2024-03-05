variable "rg" {
    type = string
}

variable "vnet_name" {
    type = string
}

output "vnet_id" {
    value = "${var.vnet_name}_id"
}