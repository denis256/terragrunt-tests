

dependency "d1" {
  config_path = "../d1"

  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

dependency "d2" {
  config_path = "../d2"

  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}