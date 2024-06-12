
variable "environment" {}

variable "scraping_concurrence_00_name" {}

variable "scraping_concurrence_00_location" {}

variable "api_offre_prix_00_name" {}

variable "api_offre_prix_00_location" {}

output "environment" {
  value = var.environment
}

output "scraping_concurrence_00_name" {
  value = var.scraping_concurrence_00_name
}

output "scraping_concurrence_00_location" {
  value = var.scraping_concurrence_00_location
}

output "api_offre_prix_00_name" {
  value = var.api_offre_prix_00_name
}

output "api_offre_prix_00_location" {
  value = var.api_offre_prix_00_location
}