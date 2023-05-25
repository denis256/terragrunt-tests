#terraform {
#  backend "s3" {
#    bucket = "mybucket"
#    key    = "path/to/my/key"
#    region = "us-east-1"
#  }
#}


module "vpc" {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
}

module "vpc2" {
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.2"
}