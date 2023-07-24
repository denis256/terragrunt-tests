plugin "terraform" {
  enabled = false
  version = "0.2.1"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

plugin "opa" {
  enabled = true
  version = "0.3.0"
  source  = "github.com/terraform-linters/tflint-ruleset-opa"
}

