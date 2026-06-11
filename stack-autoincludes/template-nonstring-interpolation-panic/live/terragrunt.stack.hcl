unit "vpc" {
  source = "${get_repo_root()}/stack-autoincludes/template-nonstring-interpolation-panic/units/vpc"
  path   = "vpc"
}

unit "app" {
  source = "${get_repo_root()}/stack-autoincludes/template-nonstring-interpolation-panic/units/app"
  path   = "app"

  autoinclude {
    dependency "vpc" {
      config_path = unit.vpc.path
    }

    inputs = {
      # ${0} interpolates a NUMBER literal; the dependency ref forces the structural partial-eval path.
      # Pre-fix this panics: "not a string" in partialEvalTemplate.
      v = "${0}-${dependency.vpc.outputs.id}"
    }
  }
}
