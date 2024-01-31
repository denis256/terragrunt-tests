dependency "prev" {
  config_path = "../mod1"
}

locals = {
  sleep = run_cmd("sleep 2")
}