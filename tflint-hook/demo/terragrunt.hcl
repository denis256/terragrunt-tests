  terraform {
    before_hook "tflint" {
      commands = ["validate"]
      execute  = ["tflint", "--minimum-failure-severity=error"]
    }
  }
