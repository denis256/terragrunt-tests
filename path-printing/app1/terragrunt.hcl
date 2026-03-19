
locals {
  
  print = run_cmd("echo", "[app1] get_repo_root = ${get_repo_root()}")

}

inputs = {
  
  path = get_repo_root()

}