terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.25"
    }
  }

}

#module "ecs_service" {
#  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
#}

output "output" {
  value = "123"
}