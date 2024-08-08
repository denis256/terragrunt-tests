dependency "env-global" {
  config_path = "${get_parent_terragrunt_dir()}/../global"
}

inputs = {
  hosted_zone_id      = dependency.env-global.outputs.public_domain_zone_id
}