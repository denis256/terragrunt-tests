terraform {
  required_providers {
    random = {}
  }
}

variable "input" {
  type = string
  default = "abc"
}

resource "random_string" "random" {
  length           = 1
  special          = false
}

locals {
  trimmed = length(var.input) > 3 ? substr(var.input, 0, 3) : var.input
}

output "random_output" {
  value = random_string.random + local.trimmed
}