dependency "y" {
  config_path = "./y"
}

terraform {
  source = "."
}

inputs = {
  dep_output = dependency.y.outputs.outputY
}
