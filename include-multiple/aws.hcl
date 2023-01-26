generate "aws" {
  path      = "aws.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region = "us-east-1"
}
EOF
}