# Hook that writes output to stdout only (no stderr).
# Expected: error message falls back to stdout content.
terraform {
  before_hook "validate_config" {
    commands = ["apply", "plan"]
    execute  = ["sh", "-c", "echo 'WARNING: deprecated provider version detected, upgrade to v5.x' && exit 1"]
  }
}
