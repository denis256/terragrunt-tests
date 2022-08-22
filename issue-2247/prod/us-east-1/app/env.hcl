import "region" {
  config_path = "../region.hcl"
}

inputs = merge(
  import.region.inputs,
  {
    env = "prod"
  },
)
