
locals {
  
  print = run_cmd("echo", "[app3] get_working_dir = ${get_working_dir()}")

}

inputs = {
  
  path = get_working_dir()

}