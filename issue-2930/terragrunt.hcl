remote_state {
  backend = "s3"
  config = {
    bucket         = "tg-issue-2930-denis-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"

    assume_role = {
      role_arn     = "arn:aws:iam::xxx:role/s3-test-access"
      duration     = "1h"
    }
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}



