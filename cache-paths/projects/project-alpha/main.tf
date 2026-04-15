module "project" {
  source = "../../modules/gcp-project"

  project_name    = "alpha"
  billing_account = "111111-111111-111111"
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

output "project_id" {
  value = module.project.project_id
}

output "network_id" {
  value = module.network.network_id
}
