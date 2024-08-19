engine {
  source = "/projects/terragrunt-engine-client"
  meta = {
    endpoint = "localhost:50051"
    token    = get_env("TG_SERVER_TOKEN")
  }
}

inputs = {
  value = "test-value"
}
