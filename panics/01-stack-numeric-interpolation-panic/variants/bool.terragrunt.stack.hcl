# Variant of the numeric panic using a BOOL literal interpolation (${true}).
# Same root cause and same crash site (partial_eval.go:246), different literal type.
# To use it: copy this file over live/terragrunt.stack.hcl, then run the same command.

unit "vpc" {
  source = "../catalog/units/vpc"
  path   = "vpc"
}

unit "app" {
  source = "../catalog/units/app"
  path   = "app"

  autoinclude {
    dependency "vpc" {
      config_path = unit.vpc.path
    }

    inputs = {
      name = "app-${true}-${dependency.vpc.outputs.vpc_id}"
    }
  }
}
