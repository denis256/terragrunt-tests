plugin "terraform" {
  enabled = true
  preset  = "recommended"

  version = "0.1.0"
  source  = "github.com/terraform-linters/tflint-ruleset-terraform"
}

plugin "azurerm" {
  enabled = true
  #preset  = "recommended"
  version = "0.20.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

config {
  module = true
}