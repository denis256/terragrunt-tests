skip = local.current_project != "p2"

locals {
  l = run_cmd("echo", "p2")
  current_project = get_env("PROJECT", "test")

}
