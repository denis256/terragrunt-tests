locals { prefix = "pre" }

unit "vpc" {
  source = "${get_repo_root()}/stack-autoincludes/object-computed-key-leak/units/vpc"
  path   = "vpc"
}

unit "app" {
  source = "${get_repo_root()}/stack-autoincludes/object-computed-key-leak/units/app"
  path   = "app"

  autoinclude {
    dependency "vpc" {
      config_path = unit.vpc.path
    }

    inputs = {
      # Pure object: key resolves (pre_key).
      pure_obj  = { "${local.prefix}_key" = "literal" }
      # Mixed object (value references dependency): pre-fix the KEY leaks local.prefix verbatim.
      mixed_obj = { "${local.prefix}_key" = dependency.vpc.outputs.id }
    }
  }
}
