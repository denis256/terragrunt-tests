
variable "test" {
  type = string
  default = "test_value"
  ephemeral = true
}

resource "local_file" "file" {
  content     = "${ephemeralasnull(var.test)} xyz"
  filename = "${path.module}/file.txt"
}


output "file" {
  value = local_file.file.filename
}
