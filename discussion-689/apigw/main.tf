
variable "function_name" {}

variable "invoke_arn" {}

resource "local_file" "file" {
  content     = " ${var.function_name} ${var.invoke_arn}"
  filename = "${path.module}/file.txt"
}
