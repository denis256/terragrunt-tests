terraform {
  extra_arguments "cleanup cloudwatch_log_group" {
    commands = ["destroy", "apply"]
    env_vars = {
      TG_ACCOUNT_NAME = "test_account_name"
      TG_AWS_REGION   = "test_aws_region"
    }
  }
}

inputs = {
  account      = "capdev"
  awsregion    = "us-east-1"
  cluster_name = "testdev-use1"
}