
provider "aws" {
  region = "us-east-1"
}

data "aws_ssm_parameter" "k3s" {
  name            = "test"
  with_decryption = true
}

resource "local_file" "k3s_config" {
  content         = "module a config"
  filename        = data.aws_ssm_parameter.k3s.value
  file_permission = "0644"
}

output "config_file" {
  value     = local_file.k3s_config.filename
  sensitive = true
}