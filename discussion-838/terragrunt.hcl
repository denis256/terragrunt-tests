
include {
  path = get_env("CI", "false") == "true" ? "terragrunt_ci.hcl": "terragrunt_local.hcl"
}
