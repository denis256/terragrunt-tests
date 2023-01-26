
terraform {

  before_hook "before" {
    commands     = ["init", "apply", "destroy"]
    execute      = ["cp", "-rfv", "${get_repo_root()}/tg-env-vars/module", "."]
  }

  after_hook "clean" {
    commands     = ["init", "apply", "destroy"]
    execute      = ["rm", "-rfv", "module"]
    run_on_error = true

  }

}