dependency "module2" {
  config_path = "../module2"

  mock_outputs = {
    attribute = "mock attribute"
    hello = "mock hello"
  }


}

inputs = {
  attribute = dependency.module2.outputs.attribute
  hello = dependency.module2.outputs.hello
}