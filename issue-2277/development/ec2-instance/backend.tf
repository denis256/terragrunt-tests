# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "s3" {
    bucket         = "environment-development"
    dynamodb_table = "terraform-statefile-locks-development"
    encrypt        = true
    key            = "development/terraform.tfstate"
    region         = "us-east-1"
  }
}
