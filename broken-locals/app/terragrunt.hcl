
#locals {
#
#  secret_vars = yamldecode(sops_decrypt_file("file.enc.yaml"))
#}

include "broken_hcl" {
  path = find_in_parent_folders("broken.hcl")
}

#dependency "module" {
#  config_path = "../module/m1"
#  mock_outputs = {
#    output_file = "mock.txt"
#  }
#  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
#}
