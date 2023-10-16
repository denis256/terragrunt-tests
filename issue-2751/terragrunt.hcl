generate "provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents = <<EOF
provider "aws" {
  region  = "eu-west-1"
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
}
EOF
}