
terraform_binary             = "/home/denis/apps/terraform/terraform_1.1.8_linux_amd64"
terraform_version_constraint = "1.1.8"

dependency "dep1" {
  config_path = "../dep1"
  mock_outputs = {
    qwe = "1123"
  }
}

