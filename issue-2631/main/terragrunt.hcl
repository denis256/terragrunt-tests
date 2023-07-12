
dependency "dep" {
  config_path = "../dependency"
}

inputs = {
  x = "y"
  a = dependency.dep.outputs.y
}