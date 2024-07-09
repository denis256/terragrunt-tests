engine {
  source  = "/projects/gruntwork/terragrunt-engine-opentofu/terragrunt-iac-engine-opentofu"
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
