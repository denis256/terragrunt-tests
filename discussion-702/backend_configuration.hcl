#remote_state {
#  backend = "s3"
#
#  generate = {
#    path      = "backend.tf"
#    if_exists = "overwrite_terragrunt"
#  }
#
#  config = {
#    bucket         = "terraform-bucket-name"
#    key            = "${path_relative_to_include()}/terraform.tfstate"
#    dynamodb_table = "dynamodb-table-name"
#    region         = "us-east-1"
#  }
#}