
variable "unique_id" {}


resource "local_file" "foo" {
  content  = "Content: ${var.unique_id}"
  filename = "file.txt"
}
