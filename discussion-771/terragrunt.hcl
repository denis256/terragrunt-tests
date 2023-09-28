generate "provider" {
  path      = "provider_aws.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region              = "us-east-1"
}
EOF
}