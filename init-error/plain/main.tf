terraform {

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 693.25"
    }
  }

  required_version = ">= 1.0.0"
}

module "ecs_service" {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
  // source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
}

