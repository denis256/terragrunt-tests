remote_state {
  backend = "gcs"

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    project  = "my-project"
    bucket   = "terraform-state"
    # prefix   = "my-project"
    location = "US-CENTRAL1"
  }
}