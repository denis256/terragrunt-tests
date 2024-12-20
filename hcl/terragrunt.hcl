terraform {
  source = "tfr:///terraform-aws-modules/ec2-instance/aws?version=5.7.1"

  after_hook "smoke_tests" {
    commands     = ["apply"]
    execute      = ["echo", "Running smoke tests"]
  }
}

errors {
    retry "transient_errors" {
        retryable_errors = [".*Error: transient network issue.*"]
        max_attempts = 3
        sleep_interval_sec = 5
    }
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name = "stacks-blog-instance"

  instance_type = "t4g.medium"
  subnet_id     = dependency.vpc.outputs.private_subnets[0]

  vpc_security_group_ids = ["sg-12345678"]
}
