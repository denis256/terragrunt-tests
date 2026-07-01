locals { prefix = "pre" }

unit "data" {
  source = "${get_repo_root()}/autoinclude-bugs/case1-object-key-leak/units/data"
  path   = "data"
}

unit "app" {
  source = "${get_repo_root()}/autoinclude-bugs/case1-object-key-leak/units/app"
  path   = "app"

  autoinclude {
    dependency "data" {
      config_path  = unit.data.path
      mock_outputs = { value = "mock" }
    }

    inputs = {
      pure_obj  = { "${local.prefix}_key" = "literal" }
      mixed_obj = { "${local.prefix}_key" = dependency.data.outputs.value }
    }
  }
}
