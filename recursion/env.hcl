locals {
  child_terragrunt_hcl = read_terragrunt_config("${get_original_terragrunt_dir()}/config.hcl")
}