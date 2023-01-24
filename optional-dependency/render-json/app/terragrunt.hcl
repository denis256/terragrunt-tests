dependency "vpc" {
  config_path = "../vpc"
  enabled    = true
  mock_outputs = {
    vpc_id = "vpc-12345678"
  }
}
dependency "db" {
  config_path = "../db"
  enabled    = false
  mock_outputs = {
    db = "123"
  }
}