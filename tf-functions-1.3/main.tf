variable "startswith1" {}
variable "startswith2" {}
variable "endswith1" {}
variable "endswith2" {}

resource "local_file" "file" {
  content     = "startswith1: ${var.startswith1}  startswith2: ${var.startswith2} endswith1: ${var.endswith1} endswith2: ${var.endswith2}"
  filename = "txt.txt"
}
