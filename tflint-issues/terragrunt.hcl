terraform {
  source = "."

  before_hook "tflint" {
    commands = ["apply", "plan"]
    execute = ["tflint", "--minimum-failure-severity=warning"] # , "--terragrunt-external-tflint"
  }

  extra_arguments "var-files" {
    commands = ["apply", "plan"]
    required_var_files = ["extra.tfvars"]
  }
}

inputs = {
  aws_region = "us-west-2"
  env = "dev"
}
