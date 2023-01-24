
variable "key1" {}

resource "local_file" "file" {
  content     = var.key1
  filename = "file.txt"
}