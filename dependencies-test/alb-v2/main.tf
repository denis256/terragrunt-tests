variable "input_value" {}

output "output_value" {
  value = var.input_value
}

resource "local_file" "file" {
  content     = "file"
  filename = "${path.module}/file.txt"
}
