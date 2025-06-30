prevent_destroy = true

terraform {
  after_hook "drop_error_code" {
    commands = ["destroy"]
    execute  = ["echo", "Error Hook executed"]

  }
}