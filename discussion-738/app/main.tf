variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

output "list_length" {
  value = length(var.vpc_security_group_ids)
}


output "list" {
  value = var.vpc_security_group_ids
}