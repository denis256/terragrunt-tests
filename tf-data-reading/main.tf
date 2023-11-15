data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    region = "us-west-2"
    bucket = "terragrunt-test-bucket-2ttejd"
    key    = "mgmt/vpc/terraform.tfstate"
  }
}
