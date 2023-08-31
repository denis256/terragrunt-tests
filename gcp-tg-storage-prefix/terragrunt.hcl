remote_state {
  backend = "gcs"

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    project  = "tg-tests-341219"
    bucket   = "tf-test-2023-08-1"
    location = "US-CENTRAL1"
  }
}