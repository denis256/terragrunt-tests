
terraform {
  #source = "."
  before_hook "fetch_kubernetes_config" {
    commands = ["apply", "plan"]
    execute  = ["echo", "Fetching Kubernetes config"]
  }

  before_hook "pwd" {
    commands = ["apply", "plan"]
    execute  = ["./script.sh"]
  }

}