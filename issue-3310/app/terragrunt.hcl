locals {
  infra_hcl  = read_terragrunt_config("../infra/terragrunt.hcl")
}

inputs = {
  infra_hcl = local.infra_hcl
}