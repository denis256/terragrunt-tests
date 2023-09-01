remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "test-s3-test-tg-2023-07-01"
    key = "app.tfstate"
    region = "us-west-2"
  }
}

dependency "module" {
  config_path = "../module"
}

inputs = {
  input = dependency.module.outputs.result
}
