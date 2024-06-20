locals {
  repo_root  = get_path_to_repo_root()
  log_print0 = run_cmd("echo", "log_print app1 0")
  log_print  = run_cmd("echo", get_path_to_repo_root())
  log_print9 = run_cmd("echo", "log_print app1 9")
}
