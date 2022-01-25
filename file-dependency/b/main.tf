
variable "k8s_config" {
  type = string

}

resource "local_file" "provider_file" {
  content         = "k8s_config  ${var.k8s_config}"
  filename        = "module_b_provider_file.txt"
  file_permission = "0644"
}