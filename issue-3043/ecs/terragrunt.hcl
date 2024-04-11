
dependency "alb" {
  config_path = "../alb"
}

inputs = {
  input_value = dependency.alb.outputs.result
}