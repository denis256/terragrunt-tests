dependency "mod1" {
  config_path = "../mod1"
}

dependency "mod0" {
  config_path = "../mod0"
  skip_outputs = true
}


inputs = {
  bucket = get_env("BUCKET", "my-terraform-bucket")
  sleep = run_cmd("bash", "-c", "sleep 1")

}
