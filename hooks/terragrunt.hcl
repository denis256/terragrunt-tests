terraform {
  before_hook "fetch_kubernetes_config" {
    commands = ["apply", "plan"]
    execute  = ["echo", "Fetching Kubernetes config"]
  }
}