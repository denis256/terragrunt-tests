remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "test-denis-2024-jenkins-ansible-demo-tf-state"
    key            = "ansible/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "jenkins-ansible-demo-lock-table"
  }
}

# Enable auto-init
terraform {
  extra_arguments "init_args" {
    commands = [
      "init"
    ]
    arguments = [
      "-force-copy",
      "-input=false"
    ]
  }
}