# Project template dir
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt.git//test/fixtures/inputs?ref=v0.68.5-beta2024102101"
}

inputs = {
  project_name = "template"

}