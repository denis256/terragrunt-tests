include "root" {
  path = find_in_parent_folders()
}
include "env" {
  path   = "../env.hcl"
  expose = true
}
import "terra" {
  config_path = "../env.hcl"
}
inputs = merge(
  import.terra.inputs,
  {
    security_groups = [
      {}
    ]
  }
)