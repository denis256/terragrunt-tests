terraform {
  before_hook "fetch_kubernetes_config" {
    commands = ["apply", "plan"]
    execute  = ["echo", "Fetching Kubernetes config"]
  }

  before_hook "sleep_test" {
    commands = ["apply", "plan"]
    execute  = ["./script.sh"]
  }

}