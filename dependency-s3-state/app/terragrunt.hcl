remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "denis-tf-dependency1"
    key = "terraform.tfstate3"
    region = "us-east-1"
    dynamodb_table = "s3-test-tg3"
    enable_lock_table_ssencryption = true


    s3_bucket_tags = {
      owner = "terragrunt integration test"
      name = "Terraform state storage"
    }

    dynamodb_table_tags = {
      owner = "terragrunt integration test"
      name = "Terraform lock table"
    }
  }
}

dependency "module" {
  config_path = "../module"
  mock_outputs = {
    output_file = "mock.txt"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  output_file = dependency.module.outputs.output_file

}