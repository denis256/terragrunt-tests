locals {
  config_content = file("${path.module}/config.txt")
}

resource "local_file" "output" {
  content  = "Config loaded:\n${local.config_content}"
  filename = "${path.module}/output.txt"
}

output "config" {
  value = local.config_content
}
