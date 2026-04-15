module "project" {
  source = "../../modules/gcp-project"

  project_name = var.project_name
}

module "iam" {
  source = "../../modules/gcp-iam"

  project_id = module.project.project_id
  role       = "roles/owner"
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

output "iam_binding_id" {
  value = module.iam.iam_binding_id
}
