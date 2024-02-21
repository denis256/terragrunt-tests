skip = local.current_project != "p3"

locals {
  l = run_cmd("echo", "p3")
  current_project = get_env("PROJECT", "test")

}
