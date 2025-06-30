remote_state {
  backend      = "s3"
  disable_init = true
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket  = "test-s3-denis-test-tg-123-121"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}