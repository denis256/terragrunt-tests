
terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "3.22.2"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
  }
}

provider "grafana" {
  url  = "https://${var.environments.servers[var.environment]}"
  auth = var.grafana_token
}
