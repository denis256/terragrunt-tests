variable "config_url" {}

variable "kubernetes_url" {}

output "output_url" {
  value = var.config_url
}

output "kubernetes_url" {
  value = var.kubernetes_url
}

