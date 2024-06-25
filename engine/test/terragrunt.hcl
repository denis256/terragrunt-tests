engine {
  source  = "github.com/acme/terragrunt-plugin-custom-opentofu"
  version = "v0.0.1" # Optionally specify version
  type    = "rpc" # Optionally specify the type of plugin
  meta = {
    tools_to_install = ["kubectl"]
    tofu_version = "1.6.0"
  }
}
