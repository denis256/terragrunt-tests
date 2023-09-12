locals {
  data = run_cmd("cat", "/etc/not-existing-dir")
}