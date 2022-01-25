
variable "k3s_config_ssm_path" {
  type = string
}

resource "local_file" "k3s_config" {
  content         = "module a config"
  filename        = var.k3s_config_ssm_path
  file_permission = "0644"
}

output "config_file" {
  value = local_file.k3s_config.filename
}