locals {
  gitlab_address   = "https://<snip>/api/v4/projects/${get_env("GITLAB_PROJECT_ID")}/terraform/state/${replace(path_relative_to_include(), "/", "_")}"
}
