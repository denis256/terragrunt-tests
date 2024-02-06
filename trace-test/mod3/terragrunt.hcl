dependency "mod1" {
  config_path = "../mod1"
}

locals  {
  sleep = run_cmd("bash", "-c", "sleep 2")
}