dependencies {
  paths = ["../lambda"]
}

dependency "lambda" {
  config_path = "../lambda"
}

inputs = {
  function_name = dependency.lambda.outputs.function_name
  invoke_arn    = dependency.lambda.outputs.invoke_arn

}