terraform {
  required_providers {
    kustomization = {
      source = "kbst/kustomization"
      version = "0.9.4"
    }
  }
}

provider "kustomization" {
  kubeconfig_path = "~/.kube/config"
}

data "kustomization_overlay" "kube_prometheus_stack" {
  helm_charts {
    name = "kube-prometheus-stack"
    namespace = "test1"
    version = "48.1.1"
    repo = "https://prometheus-community.github.io/helm-charts"
    release_name = "test1"
    include_crds = false
    skip_tests = false
    values_inline = <<VALUES
      grafana:
        adminPassword: "123"
    VALUES
  }
  kustomize_options {
    enable_helm = true
    helm_path = "helm"
  }
}

resource "kustomization_resource" "kube_prometheus_stack" {
  for_each = data.kustomization_overlay.kube_prometheus_stack.ids
  manifest = data.kustomization_overlay.kube_prometheus_stack.manifests[each.value]
}