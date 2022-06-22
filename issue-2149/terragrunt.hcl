
remote_state {
  backend = "gcs"

  config = {
    project  = "tg-tests-341219"
    location = "us-central1"
    bucket   = "test-issue-2149-11"
    prefix   = "${path_relative_to_include()}/qwe/qwe/terraform.tfstate"

    gcs_bucket_labels = {
      owner = "terragrunt_test"
      name  = "terraform_state_storage"
    }
  }
}
