
locals {
  # workaround for installing terraform versions
  # install_tf = run_cmd("${get_repo_root()}/versions-race-conditions/install-tf.sh")
}

retryable_errors = [
  "(?s).*cannot execute: Permission denied.*",
]
