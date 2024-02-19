dependency "test" {
  config_path = "../dep"
}

inputs = {
  data = dependency.test.inputs.foo
}