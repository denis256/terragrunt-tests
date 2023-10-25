locals {
  v1 = run_cmd("echo", "app1")
}

dependency "module1" {
  config_path = "../module1"

  mock_outputs = {
    value = "mock1"
  }
}

dependency "module2" {
  config_path = "../module2"

  mock_outputs = {
    value = "mock2"
  }

}
