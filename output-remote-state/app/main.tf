
terraform {
  backend "s3" {}
}

variable "input" {}

output "result" {
  value = var.input
}
