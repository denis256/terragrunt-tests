module "project" {
  source = "../../modules/gcp-project"

  project_name    = var.project_name
  billing_account = var.billing_account
}

module "network" {
  source = "../../modules/gcp-network"

  project_id   = module.project.project_id
  network_name = "alpha-vpc"
}

resource "null_resource" "config_connector" {
  triggers = {
    project_id = module.project.project_id
    role       = "roles/editor"
  }
}

variable "project_name" {
  type = string
}

variable "billing_account" {
  type = string
}

output "project_id" {
  value = module.project.project_id
}

output "network_id" {
  value = module.network.network_id
}
