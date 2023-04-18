  terraform {
    before_hook "lint" {
      commands = ["validate"]
      execute  = ["tflint"]
    }
  }
