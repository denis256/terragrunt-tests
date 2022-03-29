locals {
  x = run_cmd("echo", "${get_path_from_repo_root()}")

}