unit "a" {
  source = "${get_repo_root()}/6288/units/a"
  path   = "a"
}

stack "b" {
  source = "${get_repo_root()}/6288/stacks/b"
  path   = "b"

  values = {
    a_path = unit.a.path
  }
}

unit "c" {
  source = "${get_repo_root()}/6288/units/c"
  path   = "c"

  autoinclude {
    dependency "a" {
      config_path = unit.a.path
    }

    inputs = {
      v = dependency.a.outputs.v
    }
  }
}
