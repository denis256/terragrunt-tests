module "project" {
  source = "../../modules/gcp-project"

  project_name = "beta"
}

module "iam" {
  source = "../../modules/gcp-iam"

  project_id = module.project.project_id
  role       = "roles/owner"
  member     = "serviceAccount:sa@beta.iam.gserviceaccount.com"
}

output "project_id" {
  value = module.project.project_id
}

output "iam_binding_id" {
  value = module.iam.iam_binding_id
}
