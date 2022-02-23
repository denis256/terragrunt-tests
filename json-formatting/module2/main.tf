
variable "in_list" {}

resource "local_file" "file" {
  for_each = toset(var.in_list)
  content     = "${each.key} = ${each.value}"
  filename = "${path.module}/${each.value}"
}