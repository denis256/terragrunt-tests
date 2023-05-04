terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.25"
    }
  }

}

output "output" {
  value = "123"
}