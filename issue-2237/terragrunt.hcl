
terraform {
  //source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.4"
  source = "git::git@github.com:denis256/terraform-test-module.git//modules/test-file?ref=v0.0.1"
}


inputs = merge(
  (read_terragrunt_config("vpc.hcl").locals),
  (read_terragrunt_config("subnet.hcl").locals),

)
