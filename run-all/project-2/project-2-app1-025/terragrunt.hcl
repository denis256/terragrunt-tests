locals {
  repo_root  = get_path_to_repo_root()
  log_print0 = run_cmd("echo", "log_print 2 0")
  log_print  = run_cmd("echo", get_path_to_repo_root())
  log_print9 = run_cmd("echo", "log_print 2 0")
}

inputs = {
  str1 = "46521694"
  str2 = 123

}
