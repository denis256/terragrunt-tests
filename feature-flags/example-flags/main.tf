
variable "string_feature_flag" {
    type = string
}

variable "int_feature_flag" {
    type = number
}

output "string_feature_flag" {
    value = var.string_feature_flag
}

output "int_feature_flag" {
    value = var.int_feature_flag
}