terraform {
  before_hook "tflint" {
    commands     = ["apply", "plan"]
    execute      = ["tflint", "--minimum-failure-severity=notice"]
  }
}