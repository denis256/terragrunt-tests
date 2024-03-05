variable "resource_group" {
    type = string
}

output "rg_name" {
    value = "${var.resource_group}_example_output"
}