
dependency "ec2_instance" {
  config_path = "../ec2-instance"
  mock_outputs = {
    instance_id = "123"
  }
}

inputs = {
  instance_id = dependency.ec2_instance.outputs.instance_id
}