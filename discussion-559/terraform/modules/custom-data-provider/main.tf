terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "random" {
}

resource "random_id" "server" {
  byte_length = 8
}

output "custom_data" {
  value = random_id.server.hex
}