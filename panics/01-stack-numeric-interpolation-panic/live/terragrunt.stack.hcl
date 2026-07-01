# Reproduces a panic in the autoinclude partial evaluator.
# The "${1}" below is a NUMERIC literal interpolation, mixed in the same string
# with a deferred dependency reference. That combination is what triggers the bug.
#
# Run: terragrunt stack generate --experiment stack-dependencies

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
      # Numeric interpolation ${1} plus a deferred dependency ref in one template.
      name = "app${1}-${dependency.vpc.outputs.vpc_id}"
    }
  }
}
