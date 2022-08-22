import "env" {
  config_path = "../env.hcl"
}

inputs = merge(
  import.env.inputs,
  {
    # args to module
  },
)