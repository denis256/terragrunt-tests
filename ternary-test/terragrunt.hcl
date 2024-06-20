locals {
  val = false
  account_id = val ? "mock-value" : get_aws_account_id()
}

inputs = {
  account_id = local.account_id
}