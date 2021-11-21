dependency "module1" {
  config_path = "../modules/module1"

  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }

}

dependency "module2" {
  config_path = "../modules/module2"

  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}
