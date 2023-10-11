terraform {
  source = "."
}

include {
  path = find_in_parent_folders()
}

locals {
  common_vars = merge(
    yamldecode(
      file("${find_in_parent_folders("common.yaml")}"),
    )
  )
}

inputs = {
  mydepoutput= dependency.mydep.outputs.myoutput
}

dependency "mydep" {
  config_path = "../mydep"
}