terraform {
  source = "."
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    vpc_id = "mock-vpc-id"
  }
}

dependency "database" {
  config_path = "../database"
  mock_outputs = {
    db_endpoint = "mock-db.example.com"
  }
}

inputs = {
  vpc_id      = dependency.vpc.outputs.vpc_id
  db_endpoint = dependency.database.outputs.db_endpoint
}
