stack "networking" {
  source = "${get_repo_root()}/autoinclude-bugs/case4-nested-autoinclude-dropped/stacks/networking"
  path   = "networking"

  autoinclude {
    unit "extra" {
      source = "${get_repo_root()}/autoinclude-bugs/case4-nested-autoinclude-dropped/units/extra"
      path   = "extra"

      autoinclude {
        dependency "vpc" {
          config_path = "../vpc"
        }
        inputs = {
          vpc_id = dependency.vpc.outputs.vpc_id
        }
      }
    }
  }
}
