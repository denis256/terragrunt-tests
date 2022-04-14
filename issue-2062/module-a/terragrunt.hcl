
terraform_binary             = "/home/denis/apps/terraform/terraform_1.1.7_linux_amd64"
terraform_version_constraint = "1.1.7"

dependency "module-b" {
  config_path = "../module-b"
  mock_outputs = {
    qwe = "1123"
  }
}

