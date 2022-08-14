terraform {

  after_hook "setvariable" {
    commands = ["plan"]
    execute = ["./init.sh"]
  }

  after_hook "getEnvironment" {
    commands = ["plan"]
    execute = ["env"]
  }

  after_hook "run" {
    commands = ["plan"]
    execute = ["bash", "-c", "echo", "$PROPERTY_ID"]
  }
}
