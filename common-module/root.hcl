terraform {
  source = "${get_terragrunt_dir()}/../module"
}

inputs = {
  file = "${get_terragrunt_dir()}/file.txt"
}