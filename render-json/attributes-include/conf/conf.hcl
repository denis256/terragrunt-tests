locals {
  aws_region = "us-east-1"
}

inputs = {
  region = local.aws_region
  name   = "${local.aws_region}-bucket"
}

prevent_destroy = true
skip = true


iam_role = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
iam_assume_role_duration = 14400
terraform_binary = "/home/ubuntu/.tfenv/bin/terraform"
terraform_version_constraint = ">= 0.11"
#terragrunt_version_constraint = ">= 0.23"

download_dir = "/tmp"

retryable_errors = [
  "(?s).*Error installing provider.*tcp.*connection reset by peer.*",
  "(?s).*ssh_exchange_identification.*Connection closed by remote host.*"
]

iam_assume_role_session_name = "qwe"


