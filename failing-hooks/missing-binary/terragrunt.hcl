# Hook that references a binary that doesn't exist.
# Expected: error message shows the binary was not found (not a ProcessExecutionError).
terraform {
  before_hook "run_nonexistent" {
    commands = ["apply", "plan"]
    execute  = ["nonexistent-tool-xyz", "--check", "."]
  }
}
