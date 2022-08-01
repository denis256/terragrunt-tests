terraform {
  before_hook "before_hook_plan" {
    commands = ["plan"]
    execute  = [
      "echo",
      " ********************** running plan"
    ]
    run_on_error = false
  }

  before_hook "before_hook_apply" {
    commands = ["apply"]
    execute  = [
      "echo",
      "********************* running apply"
    ]
    run_on_error = false
  }
}