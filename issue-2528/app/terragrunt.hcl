dependency "azure" {
  config_path = "..//azure"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOF

terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}


provider "databricks" {
  host                        = "${dependency.azure.outputs.databricks_workspace_url}"
  azure_workspace_resource_id = "${dependency.azure.outputs.databricks_workspace_id}"
}
EOF
}