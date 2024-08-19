engine {
  source = "https://github.com/gruntwork-io/terragrunt-engine-go/releases/download/v0.0.3-rc2024081902/terragrunt-iac-engine-client_rpc_v0.0.3_linux_amd64.zip"
  meta = {
    endpoint = "127.0.0.1:50051"
    token    = get_env("TG_SERVER_TOKEN")
  }
}

inputs = {
  value = "test-value"
}
