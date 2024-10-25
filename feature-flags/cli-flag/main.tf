variable "boolean_feature_flag" {
    type = bool
}

variable "string_feature_flag" {
    type = string
}


output "boolean_feature_flag" {
    value = var.boolean_feature_flag
}


output "string_feature_flag" {
    value = var.string_feature_flag
}