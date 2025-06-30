engine {
  source = "/projects/gruntwork/terragrunt-engine-opentofu/terragrunt-iac-engine-opentofu"

  meta = {
    tofu_version = "6.66"
    tofu_install_dir = "/tmp/tofu"
  }
}

inputs = {
  value = "test-value"
}
