
locals {
  parent_config = read_terragrunt_config(("computed.hcl"))
  message = "${local.parent_config.computed_value} world!" # <-- Hello world!
}

inputs = {
  val = local.message
}