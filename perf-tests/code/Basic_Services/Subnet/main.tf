variable "rg" {
    type = string
}

variable "vnet_id" {
    type = string
}

variable "subnet_name" {
    type = string
}

output "subnet_id" {
    value = "${var.subnet_name}_id"
}
