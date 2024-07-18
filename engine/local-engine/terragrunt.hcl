engine {
  source  = "/projects/gruntwork/terragrunt/terragrunt-iac-engine-opentofu_v0.0.1"
  version = "v0.0.1"
  type    = "rpc"
  meta = {
    tools_to_install = ["kubectl"]
    tofu_version = "1.6.0"
  }
}

inputs = {
  value = "qwe 123"
}
