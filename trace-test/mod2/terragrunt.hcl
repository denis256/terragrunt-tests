dependency "prev" {
  config_path = "../mod1"
}

inputs = {
  bucket = get_env("BUCKET", "my-terraform-bucket")
  sleep = run_cmd("sleep 1")

}
