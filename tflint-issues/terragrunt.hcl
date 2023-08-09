terraform {
  source = "."

  before_hook "tflint" {
    commands = ["apply", "plan"]
    execute = ["tflint"] # , "--terragrunt-external-tflint"
  }
}

inputs = {
  aws_region = "us-west-2"
  env = "dev"
}
