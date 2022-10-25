variable "current_cli_args" {}

variable "current_command" {}

resource "local_file" "file" {
  content     = " file: ${var.current_cli_args} ${var.current_command} "
  filename = "${path.module}/file.txt"
}
