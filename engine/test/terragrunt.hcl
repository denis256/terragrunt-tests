engine {
  source  = "/projects/gruntwork/terragrunt-engine-opentofu/terragrunt-engine"
  version = "v0.0.1"
  type    = "rpc"
  meta = {
    tools_to_install = ["kubectl"]
    tofu_version = "1.6.0"
  }
}
