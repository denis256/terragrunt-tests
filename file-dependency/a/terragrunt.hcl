locals {
  k3s_config_ssm_path = "config.yaml"
}

inputs = {
  k3s_config_ssm_path = local.k3s_config_ssm_path
}