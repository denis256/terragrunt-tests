# Hook that writes diagnostic output to stderr and exits non-zero.
# Expected: error message shows command, exit code, and stderr content.
terraform {
  before_hook "lint_check" {
    commands = ["apply", "plan"]
    execute  = ["sh", "-c", "echo 'ERROR: resource \"aws_s3_bucket\" missing required tags: Environment, Team' >&2 && exit 2"]
  }
}
