module "project" {
  source = "../../modules/gcp-project"

  project_name = var.project_name
}

module "network" {
  source = "../../modules/gcp-network"

  project_id   = module.project.project_id
  network_name = "gamma-vpc"
}

module "iam" {
  source = "../../modules/gcp-iam"

  project_id = module.project.project_id
  role       = "roles/editor"
  member     = var.member
}

variable "project_name" {
  type = string
}

variable "member" {
  type = string
}

output "project_id" {
  value = module.project.project_id
}

output "network_self_link" {
  value = module.network.network_self_link
}

output "iam_binding_id" {
  value = module.iam.iam_binding_id
}
