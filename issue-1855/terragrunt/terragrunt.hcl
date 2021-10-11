dependency "awsmodules_tomato" {
  config_path = "../awsmodules/tomato"
}

generate "subnet-data" {
  path              = "subnet.auto.tfvars.json"
  if_exists         = "skip"
  disable_signature = true
  contents          = jsonencode(dependency.awsmodules_tomato.outputs.test_value)
}
