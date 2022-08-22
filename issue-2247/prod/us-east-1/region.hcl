import "account" {
  config_path = "../account.hcl"
}

inputs = merge(
  import.account.inputs,
  {
    region = "us-east-1"
  },
)