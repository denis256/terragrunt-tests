
dependency "ec2_instance" {
  config_path = "../ec2-instance"
  mock_outputs = {
    date = "123"
  }
}

inputs = {
  instance_id = dependency.ec2_instance.outputs.date.date
}