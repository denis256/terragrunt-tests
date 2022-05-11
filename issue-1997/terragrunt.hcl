locals {
  project_id = "tg-tests-xxx"
  project_name = "tg-tests"
  gcp_region = "us-central1"
  bucket_name = "tg-test-12345"

  service_account = "xxx@abc-123.iam.gserviceaccount.com"
  //service_account = "denis.o@linux.com"
}

remote_state {
  backend = "gcs"

  config = {
    project                     = local.project_id
    bucket                      = local.bucket_name
    prefix                      = path_relative_to_include()
    location                    = local.gcp_region
    impersonate_service_account = local.service_account
    skip_bucket_creation        = true
    //skip_bucket_versioning      = true
  }

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
