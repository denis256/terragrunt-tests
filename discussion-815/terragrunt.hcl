#skip = true


terraform {
  source = "."
}

locals {
  test       = run_cmd("pwd")
  test_2     = run_cmd("echo", "root")
  region     = "us-central1"
  zone       = "us-central1-a"
  project_id = "my-project-id"
}

inputs = {
  test = "qwe"
}