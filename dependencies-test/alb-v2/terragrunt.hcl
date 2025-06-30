dependency "alb" {
  config_path = "../alb"

}

dependency "ecs-v3" {
  config_path = "../ecs-v3"

}

inputs = {
  input_value = dependency.alb.outputs.result
}