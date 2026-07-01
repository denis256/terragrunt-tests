locals { disabled = false }

unit "data" {
  source = "${get_repo_root()}/autoinclude-bugs/case2-dead-branch-sideeffect/units/data"
  path   = "data"
}

unit "app" {
  source = "${get_repo_root()}/autoinclude-bugs/case2-dead-branch-sideeffect/units/app"
  path   = "app"

  autoinclude {
    dependency "data" {
      config_path  = unit.data.path
      mock_outputs = { value = "mock" }
    }

    inputs = {
      # condition is false; the run_cmd branch is never selected, yet it runs at generate
      guard = local.disabled ? run_cmd("touch", "/tmp/ai-case2-RAN") : "safe"
    }
  }
}
