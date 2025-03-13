locals {
  dir = "${basename(get_terragrunt_dir())}/unit.tfstate"
}
inputs = {
  data = local.dir
}