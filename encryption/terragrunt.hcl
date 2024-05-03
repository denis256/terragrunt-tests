remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    encrypt = true
    bucket = "test-s3-test-tg-123-2024"
    key = "terraform.tfstate"
    region = "us-west-2"

    encryption = {
      key_provider "pbkdf2" "my_passphrase" {
      ## Enter a passphrase here:
      passphrase = ""
      }
    }

  }
}
