engine {
  source = "github.com/gruntwork-io/terragrunt-engine-opentofu"
  #version = "v0.0.2"
  type = "rpc"
  meta = {
    tools_to_install = ["kubectl"]
    tofu_version     = "1.6.0"
  }
}

inputs = {
  value = "qwe 123"
}
